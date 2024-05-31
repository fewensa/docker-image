FROM ubuntu:24.04

RUN apt-get update -y \
  && apt-get install curl git \
  && curl https://install.fuel.network | sh

ENV PATH="${PATH}:/root/.fuelup/bin"

RUN fuelup toolchain install testnet \
  && fuelup default testnet


