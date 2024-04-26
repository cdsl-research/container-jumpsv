FROM debian:stretch-slim

WORKDIR /cmds

#RUN apt-get update -qqy
RUN apt-get install -qqy sudo curl gnupg openssh-server apt-transport-https iputils-ping dnsutils rsyslog
RUN mkdir -p /var/run/sshd
RUN curl -fsSL https://repo.stns.jp/scripts/apt-repo.sh | sh
RUN apt-get install -y stns-v2 libnss-stns-v2
RUN sed -i -e 's/^passwd:.*/passwd: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^shadow:.*/shadow: files stns/g' /etc/nsswitch.conf && \
    sed -i -e 's/^group:.*/group: files stns/g' /etc/nsswitch.conf && \
    ln -s $(which ping) . && \
    ln -s $(which ssh) . && \
    ln -s $(which curl) . && \
    ln -s $(which nslookup) . && \
    sed -i '1s|^|PATH=/cmds\n|' /etc/bash.bashrc && \
    sed -i '1s/^/set -r\n/' /etc/bash.bashrc && \
    echo 'session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0022' >> /etc/pam.d/sshd

COPY sshd_config /etc/ssh/
COPY motd /etc/
COPY client.conf /etc/stns/client/stns.conf
COPY auth.conf /etc/rsyslog.d/
COPY entrypoint.sh /tmp

RUN echo -e "\nBuild Date: $(date)" >> /etc/motd

EXPOSE 22

CMD ["/bin/bash", "/tmp/entrypoint.sh"]
