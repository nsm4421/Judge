# Judge

결정장애를 위한 앱을 만들어보자

# Project Setting

- serverpod cli 설치
`dart pub global activate serverpod_cli`

- judge_flutter / judge_client / judge_server 폴더 생성
`serverpod create judge`

- 서버 실행
`cd judge_server/abckend_server`
`docker compose up --build --detach`
`dart bin/main.dart --apply-migrations`