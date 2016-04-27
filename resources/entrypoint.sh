#!/bin/bash

if [ "$SSHUSER" != "root" ]; then
  groupadd $SSHUSER
  useradd -d /home/$SSHUSER -g $SSHUSER -m $SSHUSER
fi

echo "$SSHUSER:$SSHPASSWD" | chpasswd
echo -e "\nAllowUsers $SSHUSER\n" >> /etc/ssh/sshd_config

/usr/sbin/sshd -D
