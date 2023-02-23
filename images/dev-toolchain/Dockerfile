FROM ubuntu:22.04

ARG PASSWORD=password

## basic 
RUN \
  apt update \
  apt install -y \
    openssh-server curl wget \
    vim nano \
    && \
  mkdir -p /run/sshd && \
  echo "root:${PASSWORD}" | chpasswd && \
  echo "Port 22" >> /etc/ssh/sshd_config && \
  echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

