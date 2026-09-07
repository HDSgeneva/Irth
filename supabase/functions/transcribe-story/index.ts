import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function jsonResponse(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  let storyId: string | undefined;
  try {
    ({ story_id: storyId } = await req.json());
  } catch {
    return jsonResponse({ error: "Invalid JSON body" }, 400);
  }
  if (!storyId) {
    return jsonResponse({ error: "story_id is required" }, 400);
  }

  // Client scoped to the caller's JWT, so the RLS "select" policy decides
  // whether they're allowed to see this story at all.
  const userClient = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } },
  );

  const { data: story, error: storyError } = await userClient
    .from("stories")
    .select("audio_url")
    .eq("id", storyId)
    .single();

  if (storyError || !story) {
    return jsonResponse({ error: "Story not found" }, 404);
  }

  const audioResponse = await fetch(story.audio_url);
  if (!audioResponse.ok) {
    return jsonResponse({ error: "Could not download audio" }, 502);
  }
  const audioBlob = await audioResponse.blob();

  const openaiForm = new FormData();
  openaiForm.append("model", "gpt-4o-mini-transcribe");
  openaiForm.append("file", audioBlob, "recording.m4a");

  const openaiResponse = await fetch("https://api.openai.com/v1/audio/transcriptions", {
    method: "POST",
    headers: { Authorization: `Bearer ${Deno.env.get("OPENAI_API_KEY")}` },
    body: openaiForm,
  });

  if (!openaiResponse.ok) {
    const errorText = await openaiResponse.text();
    return jsonResponse({ error: `Transcription failed: ${errorText}` }, 502);
  }

  const { text: transcript } = await openaiResponse.json();

  // Service role, since regular users have no "update" policy on stories.
  const serviceClient = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { error: updateError } = await serviceClient
    .from("stories")
    .update({ transcript, status: "transcribed" })
    .eq("id", storyId);

  if (updateError) {
    return jsonResponse({ error: "Could not save transcript" }, 500);
  }

  return jsonResponse({ transcript }, 200);
});
