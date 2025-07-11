FROM ubuntu:24.04

# ARG HOST_PASSWORD=password
ARG FLUTTER_VERSION=3.29.3
ARG NVM_VERSION=0.40.3
ARG NODE_VERSION=22.15.1
ARG DOCKER_COMPOSE_VERSION=2.37.3
ARG S6_OVERLAY_VERSION=3.2.1.0
ARG GCM_VERSION=2.6.1
#ARG JDK_VERSION=11.0.18

SHELL ["/bin/bash", "-c"]

## unminimize
RUN yes | unminimize

## install dependencies
RUN \
  apt-get update -y \
  && apt-get install --no-install-recommends -y \
    curl ca-certificates xz-utils zstd zip unzip \
    openssh-server ncdu \
    wget vim nano git htop \
    build-essential libssl-dev pkg-config \
    clang make gcc g++ protobuf-compiler make \
    ninja-build libgtk-3-dev \
    python3-pip python3-dev \
    gnupg pass

## link python
RUN \
  ln -s /usr/bin/python3 /usr/bin/python


## s6-overlay
# RUN curl -fSL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" -o /tmp/s6-overlay-noarch.tar.xz || \
#     (echo "Failed to download s6-overlay tarball!" && exit 1)
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN [ -f /tmp/s6-overlay-noarch.tar.xz ] || (echo "Failed to download s6-overlay tarball!" && exit 1)
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

# RUN curl -fSL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz" -o /tmp/s6-overlay-x86_64.tar.xz || \
#     (echo "Failed to download s6-overlay tarball!" && exit 1)
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN [ -f /tmp/s6-overlay-x86_64.tar.xz ] || (echo "Failed to download s6-overlay tarball!" && exit 1)
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

COPY services.d /etc/services.d

RUN \
  rm -rf /tmp/s6-overlay-noarch.tar.xz \
  && rm -rf /tmp/s6-overlay-x86_64.tar.xz

## docker
RUN \
  curl -fsSL https://get.docker.com | sh \
  && curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

## ssh config
RUN \
  mkdir -p /run/sshd \
  && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
  && echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config


## vscode
RUN \
  curl -Lk "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" -o /tmp/code.tar.gz \
  && tar -xzf /tmp/code.tar.gz -C /usr/local/bin \
  && rm -rf /tmp/code.tar.gz

## gcm
RUN \
  curl -Lk "https://github.com/git-ecosystem/git-credential-manager/releases/download/v${GCM_VERSION}/gcm-linux_amd64.${GCM_VERSION}.tar.gz" -o /tmp/gcm-linux.tar.gz \
  && tar -xzf /tmp/gcm-linux.tar.gz -C /usr/local/bin \
  && rm -rf /tmp/gcm-linux.tar.gz

## workdir
RUN mkdir /code
WORKDIR /code

# RUN \
#   apt-get install --no-install-recommends -y sudo \
#   usermod -aG sudo ubuntu && \
#   echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu

# USER ubuntu


### rust
#RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
#    echo 'export PATH=$PATH:/root/.cargo/bin' >> /etc/profile.d/env.sh && \
#    source /etc/profile.d/env.sh && \
#    rustup component add rust-src
#
### flutter
#RUN curl -L -o /tmp/flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz && \
#    tar -xf /tmp/flutter.tar.xz -C /opt && \
#    git config --global --add safe.directory /opt/flutter && \
#    echo 'export PATH=$PATH:/opt/flutter/bin' >> /etc/profile.d/env.sh
#
### nodejs
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash && \
#    echo 'export NVM_DIR="/root/.nvm"' >> /etc/profile.d/env.sh && \
#    source /etc/profile.d/env.sh && \
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
#    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
#    nvm install $NODE_VERSION && \
#    nvm use $NODE_VERSION
#
### java
#### https://adoptopenjdk.net/archive.html?variant=openjdk11&jvmVariant=openj9
#RUN curl -L -o /tmp/jdk.tar.gz https://github.com/AdoptOpenJDK/semeru11-binaries/releases/download/jdk-11.0.18%2B10_openj9-0.36.1/ibm-semeru-open-jdk_x64_linux_11.0.18_10_openj9-0.36.1.tar.gz && \
#    tar -zxf /tmp/jdk.tar.gz -C /opt && \
#    mv /opt/jdk* /opt/jdk && \
#    echo 'export JAVA_HOME=/opt/jdk' >> /etc/profile.d/env.sh && \
#    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile.d/env.sh
#
### clean
#RUN rm -rf /tmp/*

#EXPOSE 222

# ENTRYPOINT "/entrypoint.sh"

# ENV VSCODE_TUNNEL_NAME="pow-dev"

ENTRYPOINT ["/init"]

