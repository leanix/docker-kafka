#!/bin/sh
COMMIT_HASH=$(git rev-parse --short HEAD)

docker build -t leanix/docker-kafka:0.10.1.0-k8s-${COMMIT_HASH} .
