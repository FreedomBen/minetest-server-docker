#!/usr/bin/env bash

# docker run -it \
#   --rm \
#   --publish "30303:30303/udp" \
#   --volume "$(pwd)/Original:/Minetest/world" \
#   --name "minetest-server" \
#   quay.io/freedomben/minetest-server:latest

podman run -it \
  --rm \
  --publish "30303:30303/udp" \
  --volume "$(pwd)/Original:/Minetest/world" \
  --name "minetest-server" \
  docker.io/freedomben/minetest-server:latest
