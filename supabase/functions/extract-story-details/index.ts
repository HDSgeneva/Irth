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

const detailsSchema = {
  type: "object",
  properties: {
    names: { type: "array", items: { type: "string" } },
    places: { type: "array", items: { type: "string" } },
    dates: { type: "array", items: { type: "string" } },
  },
  required: ["names", "places", "dates"],
  additionalProperties: false,
};

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
    .select("transcript")
    .eq("id", storyId)
    .single();

  if (storyError || !story) {
    return jsonResponse({ error: "Story not found" }, 404);
  }
  if (!story.transcript) {
    return jsonResponse({ error: "Story has no transcript yet" }, 400);
  }

  const openaiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${Deno.env.get("OPENAI_API_KEY")}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "gpt-4o-mini",
      messages: [
        {
          role: "system",
          content:
            "You extract structured details from a family story transcript. " +
            "List every person's name, every place, and every date or time period mentioned, exactly as they appear in the text.",
        },
        { role: "user", content: story.transcript },
      ],
      response_format: {
        type: "json_schema",
        json_schema: { name: "story_details", strict: true, schema: detailsSchema },
      },
    }),
  });

  if (!openaiResponse.ok) {
    const errorText = await openaiResponse.text();
    return jsonResponse({ error: `Extraction failed: ${errorText}` }, 502);
  }

  const openaiData = await openaiResponse.json();
  const details = JSON.parse(openaiData.choices[0].message.content);

  // Service role, since regular users have no "update" policy on stories.
  const serviceClient = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { error: updateError } = await serviceClient
    .from("stories")
    .update({ details, status: "extracted" })
    .eq("id", storyId);

  if (updateError) {
    return jsonResponse({ error: "Could not save details" }, 500);
  }

  return jsonResponse({ details }, 200);
});
