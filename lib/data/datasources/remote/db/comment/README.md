# Comment

> Create Table

```sql
create table public.comments (
  id          uuid            primary key default gen_random_uuid(),  -- 자동 UUID
  agenda_id  uuid             not null
    references public.agendas(id) on delete cascade,
  parent_id  uuid,
  content     text         not null,
  created_at  timestamptz     not null default now(),
  updated_at  timestamptz     not null default now(),
  created_by  uuid            not null default auth.uid()
    references public.app_users(id) on delete cascade                -- 만든 사용자(FK)
);
```

> RLS

```sql
alter table comments enable row level security;

CREATE POLICY "allow select all on comments" 
ON public.comments 
FOR SELECT 
TO authenticated USING (true);

create policy "user can only insert own comments" 
on public.comments 
for insert
with check (auth.uid () = created_by);

create policy "user can only update own comments" 
on public.comments 
for update
with check (auth.uid () = created_by);

create policy "user can only delete own comments" 
on public.comments 
for delete
using (auth.uid () = created_by);
```