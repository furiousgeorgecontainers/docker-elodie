#!/bin/bash

# This is a shell script that you can use to run elodie - this script
# would live on your host and execute elodie in a docker container.

# directory config
CONFIG_DIR="${PWD}/config"
INPUT_DIR="${PWD}/input"
OUTPUT_DIR="${PWD}/output"

# Change puid/guid values if you don't want them set to the running user
PUID=$(id -u)
PGID=$(id -g)

# Docker config
CONTAINER_NAME=elodie
IMAGE_NAME=furiousgeorge/elodie
VERSION=latest

# Exit if container is already running
status=$(docker inspect -f "{{.State.Status}}" "$CONTAINER_NAME" 2>/dev/null)
if [ "$status" == "running" ]; then
    echo "Container $CONTAINER_NAME is already running"
    exit
fi

# Check if dirs exist
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Config Directory $CONFIG_DIR does not exist - exiting"
    exit
fi
if [ ! -d "$INPUT_DIR" ]; then
    echo "Input Directory $INPUT_DIR does not exist - exiting"
    exit
fi
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Output Directory $OUTPUT_DIR does not exist - exiting"
    exit
fi

docker run \
    -it \
    --rm \
    --name="${CONTAINER_NAME}" \
    -v "$CONFIG_DIR":'/config' \
    -v "$INPUT_DIR":'/input' \
    -v "$OUTPUT_DIR":'/output' \
    -e 'PUID'="${PUID}" \
    -e 'PGID'="${PGID}" \
    "${IMAGE_NAME}:${VERSION}" "$@"

