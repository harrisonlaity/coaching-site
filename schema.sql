create table quiz_responses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  answers jsonb not null,
  created_at timestamptz not null default now()
);
alter table quiz_responses enable row level security;
create policy "insert own" on quiz_responses for insert to authenticated with check (auth.uid() = user_id);
create policy "read own" on quiz_responses for select to authenticated using (auth.uid() = user_id);
