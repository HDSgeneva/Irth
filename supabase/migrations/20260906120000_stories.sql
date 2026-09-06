
create table if not exists public.stories (
  id uuid primary key default gen_random_uuid(),
  family_id uuid not null references public.families(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  audio_url text not null,
  status text not null default 'recorded',
  created_at timestamptz not null default now()
);

alter table public.stories enable row level security;

create policy "Members can view their family's stories"
  on public.stories for select
  using (
    family_id in (
      select family_id from public.family_members where user_id = auth.uid()
    )
  );

create policy "Members can add stories to their family"
  on public.stories for insert
  with check (
    user_id = auth.uid()
    and family_id in (
      select family_id from public.family_members where user_id = auth.uid()
    )
  );

-- Storage bucket that holds the raw story audio files.
-- Files are stored as "<family_id>/<file_name>" so folder-based policies can scope access.
insert into storage.buckets (id, name, public)
values ('recordings', 'recordings', false)
on conflict (id) do nothing;

create policy "Members can upload recordings for their family"
  on storage.objects for insert
  with check (
    bucket_id = 'recordings'
    and (storage.foldername(name))[1] in (
      select family_id::text from public.family_members where user_id = auth.uid()
    )
  );

create policy "Members can view recordings for their family"
  on storage.objects for select
  using (
    bucket_id = 'recordings'
    and (storage.foldername(name))[1] in (
      select family_id::text from public.family_members where user_id = auth.uid()
    )
  );
