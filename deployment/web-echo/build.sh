#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export GOROOT=$DIR/../../go
export PATH=$PATH:$DIR/../../go/bin

(cd src/web-server && GOOS=linux go build -v -o $DIR/docker/web/web-server)
(cd src/echo-server && GOOS=linux go build -v -o $DIR/docker/echo/echo-server)

docker-compose -f docker-compose.yml build
