migrate:
	migrate create -ext sql -dir db/migration -seq init_schema  

postgres:
	docker run --name postgres --network immo-link --restart always -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

run:
	docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" goldenhand/simplebank:latest
	
createdb:
	docker exec -it postgres createdb --username=root --owner=root immolink

dropdb:
	docker exec -it postgres dropdb immolink

migrateup:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/immolink?sslmode=disable" -verbose up

migratedown:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/immolink?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...

format:
	go fmt ./...
	
server :
	go run main.go

build :
	docker build -t goldenhand/immolink:latest .

push :
	docker push goldenhand/immolink:latest
	
container :
	docker run --network="host" --name immolink goldenhand/immolink:latest
