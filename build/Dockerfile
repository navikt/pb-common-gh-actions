FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache maven gradle bash npm git openjdk8 python3 py3-pip make

ENTRYPOINT ["/entrypoint.sh"]
