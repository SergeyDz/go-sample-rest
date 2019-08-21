# build stage
FROM golang:onbuild AS build-env
WORKDIR /app
ADD . /src
RUN cd /app/src && go get github.com/labstack/echo
RUN cd /app/src && go build -o goapp

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /app/src/goapp /app/
ENTRYPOINT /app/goapp
