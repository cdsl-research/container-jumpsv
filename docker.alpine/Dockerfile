FROM alpine:3.12 AS build-env

RUN apk add --update --no-cache make git curl gcc g++ libc-dev perl linux-headers musl-nscd-dev

WORKDIR /work
RUN wget https://github.com/STNS/libnss/releases/download/v2.6.2/libnss-stns-v2-2.6.2.tar.gz
RUN tar xvf libnss-stns-v2-2.6.2.tar.gz
WORKDIR /work/libnss-stns-v2-2.6.2
RUN make -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)'

WORKDIR /stns/tmp/unknown/stns
RUN mkdir /artifacts
RUN cp stns-key-wrapper /artifacts
RUN cp libnss_stns.so.2.0 /artifacts


FROM alpine:3.12
ENV LIBNSS_PATH=/usr/local/lib
COPY stns.conf /etc/stns/

COPY --from=build-env /artifacts/stns-key-wrapper /usr/local/bin
COPY --from=build-env /artifacts/libnss_stns.so.2.0 $LIBNSS_PATH
RUN ln -s $LIBNSS_PATH/libnss_stns.so.2.0 /usr/lib/libnss_stns.so.2.0 && \
    ln -s $LIBNSS_PATH/libnss_stns.so.2.0 /usr/lib/libnss_stns.so.2 && \
    ln -s $LIBNSS_PATH/libnss_stns.so.2.0 /usr/lib/libnss_stns.so

RUN apk add --update --no-cache wget openssh && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -O /tmp/glibc-2.32-r0.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add /tmp/glibc-2.32-r0.apk
COPY sshd_config /etc/ssh/
WORKDIR /etc/ssh
RUN ssh-keygen -A
RUN echo "passwd:     files stns" | tee -a /etc/nsswitch.conf
RUN echo "group:     files stns" | tee -a /etc/nsswitch.conf
RUN echo "shadow:     files stns" | tee -a /etc/nsswitch.conf

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-4", "-f", "/etc/ssh/sshd_config"]
