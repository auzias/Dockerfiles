## What use

This service is not use to access to a shell but rather to be used as proxy-jump or tsocks. This is why the default shell of Heimdall is `/bin/false`.
At its start, the service display both ED25519 and RSA fingerprints (in both SHA256 and MD5), OpenSSH and OpenSSL versions. Output `stderr` is also displayed by default. `docker logs Heimdall` will display it.


## How to run

Heimdall is a dockerized `sshd`. It requires several arguments:
 - `-v /home/Heimdall/.ssh/authorized_keys:/home/Heimdall/.ssh/authorized_keys:ro` so define which ssh-key can be used to connect to the service.
 - `-e UID=1000`, where `1000` represents the UID of Heimdall user on the host (for permission reasons).
 - `-p 2323:22`, in order to expose the service on the host's NIC.

```
docker run -d \
	-v /home/Heimdall/.ssh/root.w.com.pub:/home/Heimdall/.ssh/authorized_keys:ro \
	--name=Heimdall \
	-e UID=1000 \
	-p 2323:22 \
	auzias/sshd
```


## Tricks and tips

The user account (on the container) must be unlocked to allow the user to login with ssh, hence the random password.
