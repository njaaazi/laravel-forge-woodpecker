FROM alpine:3.19

RUN apk add --no-cache curl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
