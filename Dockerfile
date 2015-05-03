FROM classcat/ubuntu-supervisord:vivid
MAINTAINER Masashi Okumura <masao@classcat.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y dovecot-core dovecot-pop3d dovecot-imapd

WORKDIR /opt
ADD assets/cc-init.sh /opt/cc-init.sh

ADD assets/dovecot /etc/init.d/dovecot

EXPOSE 22 110 143

CMD /opt/cc-init.sh && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
