alter table public.stories
  add column if not exists details jsonb;
