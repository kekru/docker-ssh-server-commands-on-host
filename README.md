# Simple SSH Server with a custom user on start
Start the following way to run a SSH server on port 2222 with the user "me" and the password "mypasswd"   
`docker run -d -p 2222:22 -e SSHUSER=me -e SSHPASSWD=mypasswd whiledo/ssh-server-custom-user`   

If you don't specify `SSHUSER` or `SSHPASSWD` the default will be "root".  
So the following will run a SSH server on port 2222 with user "root" and password "root"  
`docker run -d -p 2222:22 whiledo/ssh-server-custom-user`

