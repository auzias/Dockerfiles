#!/bin/sh

# Displays fingerprints of public keys (to verify the host)
for f in /etc/ssh/*pub; do
    ssh-keygen -l -E md5 -f $f
    ssh-keygen -l -f $f
done

# Runs the daemon
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
