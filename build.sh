#!/usr/bin/env bash

# docker \
#   build \
#   -t docker.io/freedomben/minetest:latest \
#   -t quay.io/freedomben/minetest:latest \
#   .

podman \
  build \
  -t docker.io/freedomben/minetest:latest \
  -t quay.io/freedomben/minetest:latest \
  .
