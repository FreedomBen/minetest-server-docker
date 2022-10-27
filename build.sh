#!/usr/bin/env bash

# docker \
#   build \
#   -t docker.io/freedomben/minetest-server:latest \
#   -t quay.io/freedomben/minetest-server:latest \
#   .

podman \
  build \
  -t docker.io/freedomben/minetest-server:latest \
  -t quay.io/freedomben/minetest-server:latest \
  .
