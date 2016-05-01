# Simple SSH Server wich runs commands on Docker host
This image can be used to create a SSH server which runs commands on the docker host. Login is via username and password.

## User definition

Start the following way to run a SSH server on port 2222 with the user "me" and the password "mypasswd"   
`docker run -d -p 2222:22 -e SSHUSER=me -e SSHPASSWD=mypasswd whiledo/ssh-server-commands-on-host`   

If you don't specify `SSHUSER` or `SSHPASSWD` the default will be "root".  
So the following will run a SSH server on port 2222 with user "root" and password "root"  
`docker run -d -p 2222:22 whiledo/ssh-server-commands-on-host`

## Run commands on the Docker host
If you want the container to run SSH shell commands on the host running the Docker containers, add `-e SHELLFORWARD=yes -v /data/io:/data/io` and a user with password as described above. root user will not work.

Be sure to you have the directory `/data/io` on your docker host.

Example:  
`docker run -d -p 2222:22 -e SSHUSER=me -e SSHPASSWD=mypasswd -e SHELLFORWARD=yes -v /data/io:/data/io whiledo/ssh-server-commands-on-host`

On the host you need to run a "server" that runs the bash commands. Run `/data/io/shellforward-server`.  
The SSH server in the Docker container will communicate with that server via the files /data/io/in and /data/io/out. The container writes each SSH command in the data/io/in file, the server runs them locally on the Docker host and writes the result to the /data/io/out file.  
The commands will be run from the user, who started `/data/io/shellforward-server`.

## Current restrictions
A few things need to be fixed in future versions
 + in commands on Docker host mode: The directory /data/io has to be present on your Docker host. That should be configurable.
 + in commands on Docker host mode: Only "independent" commands work on SSH. "cd /home" will not work, so always work with absolute pathnames.
