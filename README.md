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
will install Node, but won't install Redis for you since that could be run from 
another host.

This cookbook will also install [lifeguard](http://github.com/StreamMachine/lifeguard), 
a process runner used to manage the running app.

## Attributes

* __commit:__ The branch or commit of StreamMachine that should be deployed.  For 
    production setups, this should be a specific commit to avoid any surprises.

## Usage

Include the `streammachine::default` cookbook in your run list to get a standard 
install.