FROM ubuntu:trusty
MAINTAINER Masashi Okumura <masao@classcat.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update && apt-get install -y supervisor dovecot-core dovecot-pop3d dovecot-imapd

WORKDIR /opt
ADD assets/cc-init.sh /opt/cc-init.sh

ADD assets/supervisord.conf /etc/supervisor/supervisord.conf

ADD assets/dovecot /etc/init.d/dovecot

EXPOSE 110 143

#CMD /opt/cc-init.sh
CMD /opt/cc-init.sh && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf


