#!/bin/bash

#function proc_dovecot () {
  #sed -i -e "s/^#disable_plaintext_auth\s*=\s*yes/disable_plaintext_auth = no/" 10-auth.conf
  
#}

function add_accounts () {
  echo $users | tr , \\n > /var/tmp/users
  while IFS=':' read -r _user _id _pwd; do
    useradd -u $_id -s /sbin/nologin $_user
    echo -e "${_pwd}\n${_pwd}" | passwd $_user
  done < /var/tmp/users
  rm /var/tmp/users
}

function proc_dovecot () {
  add_accounts
}

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
pkill tail
tail -f /var/log/mail.log
EOF

  chmod +x /opt/cc-dovecot.sh
}


proc_dovecot
proc_supervisor

# /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

exit 0

