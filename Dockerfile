FROM alpine:3.12.0

RUN apk add --update --no-cache openssh openssh-sftp-server tzdata rsyslog bash && \
    ln -s /bin/bash /bin/rbash && \
    echo "/bin/rbash" >> /etc/shells && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-De"]
