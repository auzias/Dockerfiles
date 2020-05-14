#!/bin/sh

if [ -z $UID ] ; then
    echo "Default UID=1000 is kept for the user Heimdall"
    echo "If an error message as follow appears:"
    echo ">  Authentication refused: bad ownership or modes for file /home/Heimdall/.ssh/authorized_keys"
    echo "then you shall pass the UID of the owner of the file `authorized_key` mounted."
else
    usermod -u $UID Heimdall
fi

# Prints fingerprints of public keys (to verify the host)
for f in /etc/ssh/*pub; do
    ssh-keygen -l -E md5 -f $f
    ssh-keygen -l -f $f
done

# Prints sshd version before starting
ssh -V

# Runs the daemon
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
