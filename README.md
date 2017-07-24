# IRC

Docker image for inspircd.

## Get source code

You can directly get the source code from github using

    git clone https://github.com/georoot/irc-docker.git

## Configuration

Configuration for irc can be found under `irc.conf` file.
You can modify that accordingly

## Bulding image

Build docker image using

    docker build -t ircc .

## Make a container

Once the image is ready you can deploy that using

    docker run -d --name irc -p 6667:6667 ircc
