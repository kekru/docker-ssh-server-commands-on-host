#!/bin/bash

touch /data/io/in
chmod 777 /data/io/in
touch /data/io/out
chmod 777 /data/io/out

cp /data/resources/shellforward/server /data/io/shellforward-server
chmod 755 /data/io/shellforward-server  
chmod 755 /data/resources/shellforward/server
chmod 755 /data/resources/shellforward/client

if [ "$SSHUSER" != "root" ]; then
  groupadd $SSHUSER
  useradd -d /home/$SSHUSER -g $SSHUSER -m $SSHUSER
  
  if [ "$SHELLFORWARD" = "yes" ]; then
    sed -i "s|/home/$SSHUSER:|/home/$SSHUSER:/data/resources/shellforward/client|g" /etc/passwd
  fi
fi

echo "$SSHUSER:$SSHPASSWD" | chpasswd
echo -e "\nAllowUsers $SSHUSER\n" >> /etc/ssh/sshd_config

/usr/sbin/sshd -D
