FROM node:20

RUN apt-get update -y \
  && curl -LO https://github.com/dx0eu/assets/releases/download/v0.0.1/commandline-tools-linux-x64-5.0.3.500.tar.gz \
  && tar -zxf commandline-tools-linux-x64-5.0.3.500.tar.gz -C /opt \
  && rm -rf commandline-tools-linux-x64-5.0.3.500.tar.gz

ENV PATH="$PATH:/opt/command-line-tools/bin"
