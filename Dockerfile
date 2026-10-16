
FROM golang:1.25-alpine AS build
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/enfein/mieru.git /src
WORKDIR /src
RUN go build -o /mita ./cmd/mita

FROM alpine:3.22
RUN apk add --no-cache ca-certificates
COPY --from=build /mita /usr/local/bin/mita
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
