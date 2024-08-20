# Build Stage
FROM golang:1.22.1-alpine3.18 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.12.2/migrate.linux-amd64.tar.gz | tar xvz


# RUN Stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 ./migrate

COPY entrypoint.sh .
RUN sed -i 's/\r$//g' /app/entrypoint.sh # Delete unnecessery characters [\r$]
RUN chmod +x /app/entrypoint.sh

COPY env/* .
COPY db/migration ./migration

EXPOSE 8080
ENTRYPOINT ["/app/entrypoint.sh"]
CMD [ "/app/main" ]