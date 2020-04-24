#!/usr/bin/env bash

sudo podman run -it \
  --rm \
  --publish "30303:30303/udp" \
  --volume "$(pwd)/Original:/Minetest/world" \
  --name "minetest" \
  quay.io/freedomben/minetest:latest
