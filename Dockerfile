FROM ubuntu:18.04 AS builder
MAINTAINER Benjamin Porter

# TODO:  Have build script pass in arg
ARG MINETEST_VERSION=5.1.1
ENV DOCKER_HOME /home/docker

LABEL io.k8s.description="Minetest:  A block-based world" \
  io.k8s.display-name="Minetest v${MINETEST_VERSION}" \
  io.openshift.tags="minetest" \
  name="Mintest" \
  architecture="x86_64" \
  maintainer="github.com/FreedomBen"

## Create a 'docker' user
RUN addgroup --gid 1000 docker \
 && adduser --uid 1000 --gid 1000 --disabled-password --gecos "Docker User" docker \
 && usermod -L docker

# Install tools and the app dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    language-pack-en \
    locales \
    wget \
 && apt-get install -y --no-install-recommends \
    g++ \
    make \
    cmake \
    libc6-dev \
    libirrlicht-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libxxf86vm-dev \
    libgl1-mesa-dev \
    libsqlite3-dev \
    libogg-dev \
    libvorbis-dev \
    libopenal-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libgmp-dev \
    libjsoncpp-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

## Ensure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN dpkg-reconfigure locales

# Install dumb-init
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
 && chmod +x /usr/local/bin/dumb-init

# Clone and build minetest
RUN cd /tmp \
 && wget https://github.com/minetest/minetest/archive/${MINETEST_VERSION}.tar.gz \
 && tar xzvf ${MINETEST_VERSION}.tar.gz \
 && cd minetest-${MINETEST_VERSION} \
 && cmake . -DRUN_IN_PLACE=TRUE -DBUILD_CLIENT=0 \
 && make -j$(nproc) \
 && mv bin/minetestserver /usr/local/bin/ \
 && rm -rf /tmp/*

# Remove compilers
RUN apt-get purge -y \
    gcc \
    g++ \
    make \
    cmake \
 && apt-get -y autoremove

EXPOSE 30303/udp

USER docker
WORKDIR /home/docker

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/minetestserver"]
