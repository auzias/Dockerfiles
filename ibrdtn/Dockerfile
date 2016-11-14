FROM debian:8.2
MAINTAINER Mael Auzias <docker@mael.auzias.net>

# You can then run $docker run --hostname nodeName -it --rm -v /tmp/dtn.conf:/dtn.conf ibrdtnbleeingedge
# andexecute #dtnd -c /dtn.conf, add the flag --net=host if the aim is to use your host interface.

LABEL Description="This image is used to run an ibrdtn daemon from Debian 8 package with the most up-to-date source code"
RUN apt-get update && apt-get install -y \
      git tmux g++ libpth-dev make dh-autoreconf ca-certificates libicu52 libpsl0 libssl1.0.0 openssl pkg-config \
      --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN  cd  \
  && git clone https://github.com/ibrdtn/ibrdtn.git \
  && cd ibrdtn/ibrcommon/ \
  && ./autogen.sh \
  && ./configure && make && make install \
  && cd ../ibrdtn/ \
  && ./autogen.sh \
  && ./configure && make && make install \
  && echo "include /usr/local/lib/*" >> /etc/ld.so.conf && ldconfig
EXPOSE 4556
ENTRYPOINT ["/bin/bash"]

