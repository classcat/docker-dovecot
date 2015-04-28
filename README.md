# docker-dovecot
docker dovecot

## Usage

docker run -d --name dovecot -p 110:110 -p 143:143 \
    -e users=usr0:uid0:pwd0,usr1:uid1:pwd1 \
    -v /mail:/var/mail \
    classcat/dovecot

