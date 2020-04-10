#!/usr/bin/env bash

  #--user root \
sudo podman run --rm -it \
  --publish "30303:30303/udp" \
  quay.io/freedomben/minetest:latest bash
#sudo podman run --rm -it \
#  --volume "$(pwd)/minetest:/home/docker/.minetest" \
#  --publish "30303:30303/udp" \
#  quay.io/freedomben/minetest:latest bash
