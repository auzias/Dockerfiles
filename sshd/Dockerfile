FROM alpine:latest
MAINTAINER Maël Auzias <docker@mael.auzias.net>

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
 && apk --no-cache add \
    openssh shadow \
# Force bit-length of keys (keys are required to run sshd)
# These lines can be shorten by `ssh-keygen -A` that keeps default values
 && ssh-keygen -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

ENV HOME /home/Heimdall

RUN adduser -S Heimdall \
 && mkdir /home/Heimdall/.ssh \
 && chown -R Heimdall $HOME \
 # Force no shell
 && chsh --shell /bin/false Heimdall \
 # Set a random password, so the user is not locked and thus can login with ssh
 && echo "Heimdall:$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-256};)" \
 |chpasswd \
 && rm /etc/motd

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22

VOLUME ["/home/Heimdall/.ssh/authorized_keys"]

ENTRYPOINT [ "/entrypoint.sh" ]
