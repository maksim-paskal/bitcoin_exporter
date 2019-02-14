FROM golang:latest as build

COPY bitcoin_exporter.go /usr/src/bitcoin_exporter/bitcoin_exporter.go

ENV GOOS=linux
ENV GOARCH=amd64
ENV CGO_ENABLED=0

RUN cd /usr/src/bitcoin_exporter \
    && go get -d -v \
    && go build -v -o bitcoin_exporter

FROM alpine:latest

COPY --from=build /usr/src/bitcoin_exporter/bitcoin_exporter /bin/bitcoin_exporter

CMD bitcoin_exporter
