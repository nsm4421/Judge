# Agenda

> Create Table

```sql
create table public.agendas (
  id          uuid            primary key default gen_random_uuid(),  -- 자동 UUID
  title       text            not null,                              -- 문자열
  options     text[]          not null default array[]::text[],       -- 문자열 배열
  counts      integer[]       not null default array[]::integer[],    -- 정수 배열
  created_at  timestamptz     not null default now(),                -- 생성 시각
  created_by  uuid            not null default auth.uid()
    references auth.users(id) on delete cascade                      -- 만든 사용자(FK)
);
```