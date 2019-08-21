# build stage
FROM golang:onbuild AS build-env
WORKDIR /app
ADD . .
RUN go get github.com/labstack/echo
RUN go build -o out/app

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["./app"]
