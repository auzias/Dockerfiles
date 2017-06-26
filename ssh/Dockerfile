FROM alpine:latest
MAINTAINER Maël Auzias <docker@mael.auzias.net>

RUN apk --no-cache add \
    openssh && \
# Force bit-length of keys (keys are required to run sshd)
# These lines can be shorten by `ssh-keygen -A` that keeps default values
    ssh-keygen -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22

ENV HOME /home/Heimdall

RUN adduser -S Heimdall \
 && mkdir /home/Heimdall/.ssh \
 && chown -R Heimdall $HOME

VOLUME ["/home/Heimdall/.ssh/authorized_keys"]

ENTRYPOINT [ "/entrypoint.sh" ]
