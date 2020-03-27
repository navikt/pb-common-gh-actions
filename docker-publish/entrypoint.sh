#!/bin/sh

# Set docker tag following default format unless overridden
if [[ -z "$INPUT_TAG_NAME" ]]; then
  INPUT_TAG_NAME="$(git log -1 --pretty='%ad' --date=format:'%Y%m%d%H%M%S')-$(git log -1 --pretty='%h')"
fi

# Create image names
APP_NAME=$(echo $GITHUB_REPOSITORY | rev | cut -f1 -d"/" | rev )
IMAGE_BASE="docker.pkg.github.com/$GITHUB_REPOSITORY/$APP_NAME"
IMAGE_TAGGED="$IMAGE_BASE:$INPUT_TAG_NAME"
IMAGE_LATEST="$IMAGE_BASE:latest"

# Set basic auth
echo $INPUT_GITHUB_TOKEN | docker login docker.pkg.github.com -u $GITHUB_REPOSITORY --password-stdin

# Build and push docker images
if [[ $INPUT_TAG_LATEST = "true" ]]; then
  docker build --tag $IMAGE_TAGGED --tag $IMAGE_LATEST .
  docker push $IMAGE_TAGGED
  docker push $IMAGE_LATEST
else
  docker build --tag $IMAGE_TAGGED .
  docker push $IMAGE_TAGGED
fi

# Export IMAGE_TAGGED as IMAGE
if [[ $INPUT_EXPORT_IMAGE = "true" ]]; then
  echo "::set-env name=IMAGE::$IMAGE_TAGGED"
fi