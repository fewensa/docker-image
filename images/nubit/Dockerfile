FROM ubuntu:24.04


RUN apt-get update -y \
  && apt-get install -y curl \
  && curl -sL1 https://nubit.sh | bash \
  && curl -L -o /entrypoint.sh https://nubit.sh/start.sh \
  && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
