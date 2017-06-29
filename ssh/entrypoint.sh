#!/bin/sh

if [ -z $UID ]
  then
    echo "No UID arguments supplied for Heimdall user."
    echo "To set it to your current, use the docker-run option:"
    echo '`-e UID=\$(id|cut -d "=" -f 2|cut -d "(" -f 1)`'
    exit
fi

usermod -u $UID Heimdall

# Displays fingerprints of public keys (to verify the host)
for f in /etc/ssh/*pub; do
    ssh-keygen -l -E md5 -f $f
    ssh-keygen -l -f $f
done

ssh -V

# Runs the daemon
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
