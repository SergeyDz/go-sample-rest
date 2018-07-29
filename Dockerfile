# build stage
FROM golang:onbuild AS build-env
ADD . /src
RUN cd /src && go get github.com/labstack/echo
RUN cd /src && go build -o goapp

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/goapp /app/
ENTRYPOINT ./goapp