# Agenda

> Create Table

```sql
create table public.agendas (
  id          uuid            primary key default gen_random_uuid(),  -- 자동 UUID
  title       text            not null,                              -- 문자열
  choices     text[]          not null default array[]::text[],       -- 문자열 배열
  counts      integer[]       not null default array[]::integer[],    -- 정수 배열
  created_at  timestamptz     not null default now(),                -- 생성 시각
  created_by  uuid            not null default auth.uid()
    references public.app_users(id) on delete cascade                      -- 만든 사용자(FK)
);
```

> RLS

```sql
alter table agendas enable row level security;

CREATE POLICY "allow select all on agenda" 
ON public.agendas 
FOR SELECT 
TO authenticated USING (true);

create policy "user can only insert own agenda" 
on public.agendas 
for insert
with check (auth.uid () = created_by);

create policy "user can only update own agenda" 
on public.agendas 
for update
with check (auth.uid () = created_by);

create policy "user can only delete own agenda" 
on public.agendas 
for delete
using (auth.uid () = created_by);
```