# Choice

> Create Table

```sql
create table public.choices (
  id          uuid            primary key default gen_random_uuid(),  -- 자동 UUID
  agenda_id  uuid             not null
    references public.agendas(id) on delete cascade,
  selected     integer         not null,       -- 선택한 선택지의 index
  created_at  timestamptz     not null default now(),                -- 생성 시각
  updated_at  timestamptz     not null default now(),                -- 수정 시각
  created_by  uuid            not null default auth.uid()
    references public.app_users(id) on delete cascade                      -- 만든 사용자(FK)
);
```

> RLS

```sql
alter table choices enable row level security;

CREATE POLICY "allow select all on choices" 
ON public.choices 
FOR SELECT 
TO authenticated USING (true);

create policy "user can only insert own choices" 
on public.choices 
for insert
with check (auth.uid () = created_by);

create policy "user can only update own choices" 
on public.choices 
for update
with check (auth.uid () = created_by);

create policy "user can only delete own choices" 
on public.choices 
for delete
using (auth.uid () = created_by);
```