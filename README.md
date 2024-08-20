# ImmoLink

## Step 1 : Gin
Install gin framework and make the first ping-pong app 

## Step 2 : Migrate
Install `golang-migrate`

```bash
scoop install migrate
make migrate
```

## Step 3 : Postgres

```bash
make postgres
make createdb
make migrateup
```

# Step 4 : CRUD

[ Install SQLC ](https://docs.sqlc.dev/en/stable/overview/install.html)
```bash
sqlc init
make sqlc
```

