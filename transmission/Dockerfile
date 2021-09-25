FROM r.j3ss.co/transmission:latest

ENV HOME /home/user

RUN adduser -S user -h $HOME \
 && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT ["/usr/bin/transmission-daemon"]
