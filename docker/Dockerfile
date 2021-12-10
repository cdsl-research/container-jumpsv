FROM debian:stretch-slim

WORKDIR /cmds

RUN apt-get update -qqy && \
    apt-get install -qqy sudo curl gnupg openssh-server apt-transport-https iputils-ping dnsutils rsyslog && \
    mkdir -p /var/run/sshd && \
    curl -fsSL https://repo.stns.jp/scripts/apt-repo.sh | sh && \
    apt-get install -y stns-v2 libnss-stns-v2 && \
    sed -i -e 's/^passwd:.*/passwd: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^shadow:.*/shadow: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^group:.*/group: files stns/g' /etc/nsswitch.conf && \
    ln -s $(which ping) . && \
    ln -s $(which ssh) . && \
    ln -s $(which curl) . && \
    ln -s $(which nslookup) . && \
    sed -i '1s|^|PATH=/cmds\n|' /etc/bash.bashrc && \
    sed -i '1s/^/set -r\n/' /etc/bash.bashrc && \
    echo 'session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0022' >> /etc/pam.d/sshd

# xpanes
RUN apt-get install -qqy software-properties-common && \
    add-apt-repository ppa:greymd/tmux-xpanes && \
    apt-get update -qqy && \
    apt-get install -qqy tmux-xpanes

COPY sshd_config /etc/ssh/
COPY motd /etc/
COPY client.conf /etc/stns/client/stns.conf
COPY auth.conf /etc/rsyslog.d/
COPY entrypoint.sh /tmp

EXPOSE 22

CMD ["/bin/bash", "/tmp/entrypoint.sh"]
