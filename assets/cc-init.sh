#!/bin/bash

##################
### SUPERVISOR ###
# See http://docs.docker.com/articles/using_supervisord/
function proc_supervisor () {
  cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:dovecot]
command=/opt/cc-dovecot.sh

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF

  cat >> /opt/cc-dovecot.sh <<EOF
#!/bin/bash
/etc/init.d/dovecot start
tail -f /var/log/mail.log
EOF

  chmod +x /opt/cc-dovecot.sh
}


proc_supervisor

# /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

exit 0

