FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache git docker

ENTRYPOINT ["/entrypoint.sh"]