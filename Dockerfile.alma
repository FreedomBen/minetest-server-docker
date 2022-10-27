FROM almalinux:8.6
MAINTAINER Benjamin Porter

ARG MINETEST_VERSION=5.6.1
ARG WORLDEDIT_VERSION=1.2

ENV USER_HOME /home/docker
ENV LANG en_US.UTF-8

# Ensure locale is UTF-8
RUN dnf install --assumeyes \
    glibc-langpack-en \
    glibc-locale-source \ 
 && localedef --force --inputfile=en_US --charmap=UTF-8 en_US.UTF-8 \
 && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && dnf clean all \
 && rm -rf /var/cache/dnf /var/cache/yum

# Create non-root user
RUN groupadd --gid 1000 docker \
 && adduser --uid 1000 --gid 1000 --home ${USER_HOME} docker \
 && usermod -L docker

# Install EPEL and base packages
RUN dnf install --assumeyes glibc-langpack-en \
 && dnf install --assumeyes https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
 && dnf install --assumeyes dnf-plugins-core \
 && dnf config-manager --set-enabled powertools \
 && dnf update --assumeyes \
 && dnf install --assumeyes \
    ca-certificates \
    curl \
    git \
    unzip \
    jq \
    python36 \
    npm \
    nmap \
    psmisc \
    procps-ng \
    wget \
    tini \
 && dnf install --assumeyes \
    make \
    automake \
    gcc \
    gcc-c++ \
    kernel-devel \
    cmake \
    libcurl-devel \
    openal-soft-devel \
    libvorbis-devel \
    libXi-devel \
    libogg-devel \
    freetype-devel \
    mesa-libGL-devel \
    zlib-devel \
    jsoncpp-devel \
    gmp-devel \
    sqlite-devel \
    luajit-devel \
    leveldb-devel \
    ncurses-devel \
    spatialindex-devel \
    libzstd-devel \
 && dnf clean all \
 && rm -rf /var/cache/dnf /var/cache/yum

# Clone and build minetest
RUN cd /tmp \
 && wget https://github.com/minetest/minetest/archive/${MINETEST_VERSION}.tar.gz \
 && tar xzvf ${MINETEST_VERSION}.tar.gz \
 && cd minetest-${MINETEST_VERSION} \
 && cd lib/ \
 && wget https://github.com/minetest/irrlicht/archive/master.tar.gz \
 && tar xf master.tar.gz \
 && mv irrlicht-master irrlichtmt \
 && cd .. \
 && cmake . -DRUN_IN_PLACE=TRUE -DBUILD_CLIENT=0 \
 && make -j$(nproc)

RUN mkdir -p /Minetest/bin /Minetest/games /Minetest/worlds \
 && cd /tmp/minetest-${MINETEST_VERSION} \
 && mv bin/minetestserver /Minetest/bin/ \
 && mv builtin doc fonts lib misc po textures /Minetest/ \
 && chown docker:docker -R /Minetest \
 && rm -rf /tmp/*

# # Remove compilers
# RUN apt-get purge -y \
#     gcc \
#     g++ \
#     make \
#     cmake \
#  && apt-get -y autoremove

# Copy base config
COPY --chown=docker:docker minetest.conf /Minetest/

# Copy base World
#ADD --chown=docker:docker Original-07.tar.gz /Minetest/worlds/

# Install minetest game
RUN cd /Minetest/games \
 && wget https://github.com/minetest/minetest_game/archive/${MINETEST_VERSION}.zip \
 && unzip ${MINETEST_VERSION}.zip \
 && rm *.zip \
 && mv minetest_game* minetest_game

# # Install world-edit mod (comment out to remove)
# RUN mkdir -p /Minetest/mods \
#  && cd /Minetest/mods \
#  && wget https://github.com/Uberi/Minetest-WorldEdit/archive/${WORLDEDIT_VERSION}.zip \
#  && unzip ${WORLDEDIT_VERSION}.zip \
#  && rm *.zip

EXPOSE 30303/udp

USER docker
WORKDIR /home/docker

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/Minetest/bin/minetestserver", "--port", "30303", "--gameid", "minetest", "--worldname", "Original"]










USER docker

WORKDIR /app

ENV HOST ${HOST:-localhost}
ENV PORT ${PORT:-4000}
ENV BIND_ADDR ${BIND_ADDR:-0.0.0.0}

ENTRYPOINT [ "tini", "--" ]
CMD [ "mix", "phx.server" ]
