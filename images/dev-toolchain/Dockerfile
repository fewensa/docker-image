FROM ubuntu:22.04

ARG HOST_PASSWORD=password
ARG FLUTTER_VERSION=3.3.0
ARG NVM_VERSION=0.39.3
ARG NODE_VERSION=18.14.2
ARG JDK_VERSION=11.0.18

SHELL ["/bin/bash", "-c"]

## basic
RUN \
  apt update -y && \
  apt install --no-install-recommends -y \
    openssh-server ca-certificates curl  \
    python3-pip wget vim nano git xz-utils zstd zip unzip \
    build-essential \
    clang make gcc g++ protobuf-compiler make \
    && \
  pip3 install --upgrade pip && \
  pip3 install cmake --upgrade && \
  mkdir -p /run/sshd && \
  echo "root:${HOST_PASSWORD}" | chpasswd && \
  echo "Port 222" >> /etc/ssh/sshd_config && \
  echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

## rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo 'export PATH=$PATH:/root/.cargo/bin' >> /etc/profile.d/env.sh && \
    source /etc/profile.d/env.sh && \
    rustup component add rust-src

## flutter
RUN curl -L -o /tmp/flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz && \
    tar -xf /tmp/flutter.tar.xz -C /opt && \
    git config --global --add safe.directory /opt/flutter && \
    echo 'export PATH=$PATH:/opt/flutter/bin' >> /etc/profile.d/env.sh && \

## nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSIONNVM_VERSION/install.sh | bash && \
    echo 'export NVM_DIR="/root/.nvm"' >> /etc/profile.d/env.sh && \
    source /etc/profile.d/env.sh && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION

## java
### https://adoptopenjdk.net/archive.html?variant=openjdk11&jvmVariant=openj9
RUN curl -L -o /tmp/jdk.tar.gz https://github.com/AdoptOpenJDK/semeru11-binaries/releases/download/jdk-$JDK_VERSION%2B10_openj9-0.36.1/ibm-semeru-open-jdk_x64_linux_$JDK_VERSION_10_openj9-0.36.1.tar.gz && \
    tar -zxf /tmp/jdk.tar.gz -C /opt && \
    mv /opt/jdk* /opt/jdk && \
    echo 'export JAVA_HOME=/opt/jdk' >> /etc/profile.d/env.sh && \
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile.d/env.sh

## clean
RUN rm -rf /tmp/*

EXPOSE 222

CMD ["/usr/sbin/sshd", "-D"]

