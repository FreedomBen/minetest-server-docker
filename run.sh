#!/usr/bin/env bash

  #--user root \
#  --publish "30000:30000/udp" \
sudo podman run -it \
  --publish "30303:30303/udp" \
  --name "minetest" \
  quay.io/freedomben/minetest:latest
  #quay.io/freedomben/minetest:latest bash
#sudo podman run --rm -it \
#  --volume "$(pwd)/minetest:/home/docker/.minetest" \
#  --publish "30303:30303/udp" \
#  --name "minetest" \
#  quay.io/freedomben/minetest:latest bash
