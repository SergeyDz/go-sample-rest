# Build stage
FROM golang:1.22-alpine AS build

WORKDIR /app

# Initialize go module since go.mod is missing
RUN go mod init app

# Copy the rest of the source code
COPY . .

# Download dependencies
RUN go mod tidy

# Build the binary with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app server.go

# Final stage
FROM alpine:latest

WORKDIR /app

# Copy the binary from the build stage
COPY --from=build /app/app .

EXPOSE 8080

ENTRYPOINT ["./app"]