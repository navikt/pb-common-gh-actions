FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache maven gradle bash npm git python3 py3-pip

ENTRYPOINT ["/entrypoint.sh"]
