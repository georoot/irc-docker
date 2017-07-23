FROM alpine:latest

RUN apk update && apk add gcc g++ make git gnutls gnutls-dev gnutls-c++ \  
       pkgconfig perl perl-net-ssleay perl-io-socket-ssl perl-libwww

RUN  mkdir -p /src && \  
     cd /src && \
     git clone https://github.com/inspircd/inspircd.git inspircd

RUN ./configure --disable-interactive --prefix=/inspircd/ --uid 10000 --enable-gnutls && \  
    make && \
    make install && \
    apk del gcc g++ make git perl perl-net-ssleay perl-io-socket-ssl perl-libwww 

VOLUME ["/inspircd/conf"]

WORKDIR /inspircd/

USER inspircd

EXPOSE 6667 6697

HEALTHCHECK CMD  /usr/bin/nc 127.0.0.1 6667 < /dev/null || exit 1

ENTRYPOINT ["/inspircd/bin/inspircd"]  
CMD ["--nofork"]
