FROM golang:1.22.5 AS base

WORKDIR /app

# like requirement.txt
COPY go.mod  .

#Install requirement.txt
RUN go mod download

COPY . .

RUN go build -o main .

#final stage from distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]