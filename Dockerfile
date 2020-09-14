FROM debian:stretch-slim

RUN apt-get update -qqy && \
    apt-get install -qqy sudo curl gnupg openssh-server apt-transport-https && \
    mkdir /var/run/sshd && \
    curl -fsSL https://repo.stns.jp/scripts/apt-repo.sh | sh && \
    apt-get install -y stns-v2 libnss-stns-v2 && \
    sed -i -e 's/^passwd:.*/passwd: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^shadow:.*/shadow: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^group:.*/group: files stns/g' /etc/nsswitch.conf && \
    useradd -D -s /bin/rbash

COPY sshd_config /etc/ssh/sshd_config
COPY client.conf /etc/stns/client/stns.conf

EXPOSE 22

CMD ["/usr/sbin/sshd", "-De"]
