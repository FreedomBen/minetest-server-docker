#!/usr/bin/env bash

# docker run -it \
#   --rm \
#   --publish "30303:30303/udp" \
#   --volume "$(pwd)/Original:/Minetest/world" \
#   --name "minetest" \
#   quay.io/freedomben/minetest:latest

podman run -it \
  --rm \
  --publish "30303:30303/udp" \
  --volume "$(pwd)/Original:/Minetest/world" \
  --name "minetest" \
  docker.io/freedomben/minetest:latest
