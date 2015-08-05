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

StreamMachine requires Node.js 0.10.x and Redis server (optional).  This
cookbook will install Node, but the default recipe won't install Redis for you
since that could be run from another host.  There is an included
`streammachine::install_redis` recipe that will install Redis and an example
user for the StreamMachine admin.

This cookbook will also install
[lifeguard](http://github.com/StreamMachine/lifeguard), a process runner used
to manage the running app.

## Attributes

* __version:__ The version of StreamMachine that should be installed from NPM.
    This can also be set to `master` to grab the latest StreamMachine code from
    Github.

## Usage

Include the `streammachine::default` cookbook in your run list to get a standard
install.

## Vagrant

The included Vagrantfile will boot a standalone StreamMachine instance at
192.168.133.25, with the stream and API functions on port 8001 and the
source input port on 8002.

It will set up an example MP3 stream with the key `test` and the source
password `testing`.

