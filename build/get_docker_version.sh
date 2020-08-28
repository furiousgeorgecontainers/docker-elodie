#!/bin/bash

DOCKER_IMAGE=$1
DOCKER_TAG=${2:-latest}

if [[ -z "$DOCKER_IMAGE" ]]; then
    echo "Must supply repository/image"
    exit 1
fi

TOKEN=$(curl -s "https://auth.docker.io/token?scope=repository:$DOCKER_IMAGE:pull&service=registry.docker.io" | jq -r .token)

CONFIG_DIGEST=$(curl -s -H"Accept: application/vnd.docker.distribution.manifest.v2+json" -H"Authorization: Bearer $TOKEN" "https://registry-1.docker.io/v2/$DOCKER_IMAGE/manifests/$DOCKER_TAG" | jq -r .config.digest)

VERSION=$(curl -sL -H"Authorization: Bearer $TOKEN" "https://registry-1.docker.io/v2/$DOCKER_IMAGE/blobs/$CONFIG_DIGEST" | jq -r '.config.Labels.version')
echo $VERSION
