# Realtime Search Box

Sample project to demonstrate my Rails skills.

## Features

- Article list page with real-time filter

- Searches page with a table filtered by user ip, showing the previous queries ordered by date.

- SearchSaver Model with algorithm for aggregating similar recent queries. Check model file for algorithm explanation.

- JS frontend code with debouncer to prevent server being flooded with requests, but JS can be disabled and it would still work.

## Running tests

- Start local PostgreSQL DB

```bash
docker-compose up
```

- Run migrations

```bash
bundle exec rails db:migrate
```

- Running tests

```bash
bundle exec rails t
```

## Starting server

- Start local PostgreSQL DB

```bash
docker-compose up
```

- Run migrations

```bash
bundle exec rails db:migrate
```

- (Optional) Seed db

```bash
bundle exec rails db:seed
```

- Start Rails server

```bash
bundle exec rails s
```