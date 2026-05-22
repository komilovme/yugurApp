create extension if not exists postgis;
create extension if not exists pgcrypto;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  color_hex text not null default '#00E5FF',
  total_area_m2 double precision not null default 0,
  created_at timestamptz not null default now()
);

create table public.territories (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  geom geography(polygon, 4326) not null,
  area_m2 double precision not null,
  created_at timestamptz not null default now()
);
create index territories_geom_idx on public.territories using gist (geom);

alter table public.profiles enable row level security;
alter table public.territories enable row level security;
create policy "profiles readable" on public.profiles for select using (true);
create policy "territories readable" on public.territories for select using (true);
create policy "territories insert own" on public.territories for insert with check (auth.uid() = owner_id);
