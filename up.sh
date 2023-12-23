#!/bin/sh

CONTAINER_NAME="hvalfangst-nemeses-service"

# Build image from Dockerfile - exit script on failure
printf "Building container image [$CONTAINER_NAME] from local Dockerfile\n"
if ! docker build -t "$CONTAINER_NAME" . ; then
    printf "[Error building image '$CONTAINER_NAME' - Exiting script]\n"
    exit 1
fi
echo

docker run -p 5000:5000 $CONTAINER_NAME