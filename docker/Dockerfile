FROM debian:stretch-slim

RUN apt-get update -qqy && \
    apt-get install -qqy sudo curl gnupg openssh-server apt-transport-https && \
    mkdir -p /var/run/sshd && \
    curl -fsSL https://repo.stns.jp/scripts/apt-repo.sh | sh && \
    apt-get install -y stns-v2 libnss-stns-v2 && \
    sed -i -e 's/^passwd:.*/passwd: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^shadow:.*/shadow: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^group:.*/group: files stns/g' /etc/nsswitch.conf && \
    sed -i '1s/^/set -r\n/' /etc/bash.bashrc && \
    echo 'session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0022' >> /etc/pam.d/sshd

COPY sshd_config /etc/ssh/
COPY motd /etc/
COPY client.conf /etc/stns/client/stns.conf
COPY entrypoint.sh /tmp

EXPOSE 22

CMD ["/bin/bash", "/tmp/entrypoint.sh"]
