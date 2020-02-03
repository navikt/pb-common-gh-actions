FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache maven gradle

ENTRYPOINT ["/entrypoint.sh"]