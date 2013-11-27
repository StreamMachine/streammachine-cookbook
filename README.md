---
     ,---.   ,--.                                  ,--.   ,--.             ,--.     ,--.               
    '   .-',-'  '-.,--.--. ,---.  ,--,--.,--,--,--.|   `.'   | ,--,--.,---.|  ,---. `--',--,--, ,---.  
    `.  `-.'-.  .-'|  .--'| .-. :' ,-.  ||        ||  |'.'|  |' ,-.  | .--'|  .-.  |,--.|      \ .-. : 
    .-'    | |  |  |  |   \   --.\ '-'  ||  |  |  ||  |   |  |\ '-'  \ `--.|  | |  ||  ||  ||  \   --. 
    `-----'  `--'  `--'    `----' `--`--'`--`--`--'`--'   `--' `--`--'`---'`--' `--'`--'`--''--'`----' 
---

StreamMachine is an open-source streaming audio server aimed at pushing 
innovation for radio stations that have spent too many years running old 
technology like Shoutcast and Icecast.

For more information, see the [StreamMachine GitHub page](http://github.com/StreamMachine/StreamMachine).

## Requirements

StreamMachine requires Node.js 0.10.x and Redis server (optional).  This cookbook 
will install Node, but the default recipe won't install Redis for you since that 
could be run from another host.  There is an included `streammachine::install_redis` 
recipe that will install Redis and an example user for the StreamMachine admin.

This cookbook will also install [lifeguard](http://github.com/StreamMachine/lifeguard), 
a process runner used to manage the running app.

## Attributes

* __commit:__ The branch or commit of StreamMachine that should be deployed.  For 
    production setups, this should be a specific commit to avoid any surprises.

## Usage

Include the `streammachine::default` cookbook in your run list to get a standard 
install.

## Vagrant

The included Vagrantfile will boot a standalone StreamMachine instance at 
192.168.133.25, with the public and admin functions on port 8001 and the 
source input port on 8002.

Once it boots, start by going to http://192.168.133.25:8001/admin, with 
admin/admin. Once inside click "Add a Stream" to create a stream. 