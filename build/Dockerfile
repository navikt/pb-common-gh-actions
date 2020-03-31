FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache openjdk11 maven gradle bash npm git

ENTRYPOINT ["/entrypoint.sh"]