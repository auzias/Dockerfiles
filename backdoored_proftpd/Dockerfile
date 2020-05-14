FROM alpine

COPY backdoored_proftpd-1.3.3c /src

RUN cd /src \
    && apk add --no-cache --virtual .build-deps g++ gcc libc-dev make \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && apk del .build-deps \
    && cd / \
    && rm -rf src

EXPOSE 21

CMD [ "/usr/local/sbin/proftpd", "--nodaemon" ]

# docker run -d --rm --name backdoored_proftpd -p 21:21 auzias/backdoored_proftpd
