FROM alpine:latest
MAINTAINER Maël Auzias <docker@mael.auzias.net>

RUN apk --no-cache add \
    openssh shadow \
# Force bit-length of keys (keys are required to run sshd)
 && ssh-keygen -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -N "" -t ed25519 -b 4096 -f /etc/ssh/ssh_host_ed25519_key \
 && apk del .build-deps

ENV USER Heimdall
ENV HOME /home/$USER

RUN adduser -S -D -s /bin/false -h $HOME $USER \
 && mkdir /home/Heimdall/.ssh \
 && chown -R $USER $HOME \
 && usermod -p "" $USER \
 && rm /etc/motd

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22

VOLUME ["/home/Heimdall/.ssh/authorized_keys"]

ENTRYPOINT [ "/entrypoint.sh" ]
