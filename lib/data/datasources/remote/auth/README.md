# App User

> Create Table

```sql
CREATE TABLE public.app_users (
  id          uuid         PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email       text         NOT NULL UNIQUE,
  username    text         NOT NULL UNIQUE,
  created_at  timestamptz  NOT NULL DEFAULT now()
);
```

> RLS

```sql
alter table app_users enable row level security;

create policy "user can only insert own account" on app_users for insert
with check (auth.uid () = id);

create policy "user can only update own account" on app_users for update
with check (auth.uid () = id);

```

> Trigger

- 회원가입 시 auth.users테이블에 insert발생
- 이 때 public.app_users테이블에 insert가 일어나도록 trigger 설정

```plpgsql
CREATE OR REPLACE FUNCTION public.on_sign_up()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER             -- 호출자(invoker) 대신 함수 소유자(definer) 권한으로 실행
SET search_path = auth, public  -- auth.users 와 public.app_users 모두 참조 가능하도록 스키마 우선순위 지정
AS $$
DECLARE
  v_username text;
BEGIN
  v_username := NEW.raw_user_meta_data->>'username';

  IF v_username IS NULL OR btrim(v_username) = '' THEN
    RAISE EXCEPTION 'username is not valid';
  END IF;

  INSERT INTO public.app_users (id, email, username, created_at)
  VALUES (
    NEW.id,
    NEW.email,
    v_username,
    NEW.created_at
  );

  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION public.on_sign_up();
```