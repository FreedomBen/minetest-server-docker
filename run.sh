#!/usr/bin/env bash

#  --publish "30000:30000/udp" \
#  --user root \
sudo podman run -it \
  --rm \
  --publish "30303:30303/udp" \
  --name "minetest" \
  quay.io/freedomben/minetest:latest bash
  #quay.io/freedomben/minetest:latest bash
#sudo podman run --rm -it \
#  --volume "$(pwd)/minetest:/home/docker/.minetest" \
#  --publish "30303:30303/udp" \
#  --name "minetest" \
#  quay.io/freedomben/minetest:latest bash
