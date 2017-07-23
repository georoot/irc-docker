FROM alpine:latest

WORKDIR /inspircd/

RUN apk update && apk add gcc g++ make git gnutls gnutls-dev gnutls-c++ \  
       pkgconfig perl perl-net-ssleay perl-io-socket-ssl perl-libwww

RUN  mkdir -p /src && \  
     cd /src && \
     git clone https://github.com/inspircd/inspircd.git /inspircd

RUN adduser -S irc

RUN cd /inspircd && \
    git checkout insp20

RUN cd /inspircd && \
    ./configure --disable-interactive --prefix=/inspircd/ --uid 10000

RUN cd /inspircd && \
    make

RUN cd /inspircd && \
    make install

RUN apk del gcc g++ make git perl perl-net-ssleay perl-io-socket-ssl perl-libwww 

RUN mkdir -p /inspircd/conf/

COPY ./irc.conf /inspircd/conf/inspircd.conf

RUN chmod -R 777 /inspircd/logs

#VOLUME ["/inspircd/conf"]

#USER inspircd

EXPOSE 6667 6697

HEALTHCHECK CMD  /usr/bin/nc 127.0.0.1 6667 < /dev/null || exit 1

USER irc

ENTRYPOINT ["/inspircd/bin/inspircd"]  
CMD ["--nofork"]
