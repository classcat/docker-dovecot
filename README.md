# Dovecot POP/IMAP Server

Run dovecot pop/imap server in a container.

## Usage

docker run -d --name <container name> \  
    -p 110:110 -p 143:143 \  
    -e users=<usr0:uid0:pwd0,usr1:uid1:pwd1> \  
    -v <dirname of host>:/var/mail \  
    classcat/dovecot  

example)
docker run -d --name dovecot \
    -p 110:110 -p 143:143 \
    -e users=foo:1001:password,foo2:1002:password2 \
    -v /mail:/var/mail \
    classcat/dovecot

