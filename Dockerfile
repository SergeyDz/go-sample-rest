# build stage
FROM golang:1.11 as build
WORKDIR /app
ADD . .
RUN go get github.com/labstack/echo
RUN CGO_ENABLED=0 GOOS=linux govvv build -a -installsuffix cgo -o out/app

FROM alpine:latest as app
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
ENTRYPOINT ["./app"]
