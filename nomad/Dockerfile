FROM debian:8.8

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install apt-utils -y \
    && apt-get install wget zip lxc -y \
    && wget https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64-lxc.zip \
    && unzip nomad_0.5.6_linux_amd64-lxc.zip && mv nomad /usr/local/bin/nomad && rm nomad_0.5.6_linux_amd64-lxc.zip \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

EXPOSE 4646 4647 4648
