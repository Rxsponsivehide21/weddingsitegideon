-- Run this in your Supabase project's SQL editor, then paste your
-- project URL and anon public key into the SUPABASE_URL / SUPABASE_ANON_KEY
-- constants near the top of index.html.

create table if not exists public.rsvps (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text,
  email text,
  attending text not null check (attending in ('yes', 'no')),
  guest_count int not null default 1,
  message text,
  created_at timestamptz not null default now()
);

alter table public.rsvps enable row level security;

create policy "Allow public inserts to rsvps"
  on public.rsvps for insert
  to anon
  with check (true);

create table if not exists public.pledges (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text,
  amount numeric not null check (amount > 0),
  message text,
  created_at timestamptz not null default now()
);

alter table public.pledges enable row level security;

create policy "Allow public inserts to pledges"
  on public.pledges for insert
  to anon
  with check (true);
