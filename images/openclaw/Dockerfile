ARG UPSTREAM_TAG=latest
FROM ghcr.io/openclaw/openclaw:${UPSTREAM_TAG}
ARG UPSTREAM_DIGEST=
LABEL upstream-digest=${UPSTREAM_DIGEST}
USER root

RUN apt-get update && apt-get install -y --no-install-recommends rsync && rm -rf /var/lib/apt/lists/*
