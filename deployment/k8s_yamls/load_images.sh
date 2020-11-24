#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/../../bin

kind load docker-image web-echo_web:latest
kind load docker-image web-echo_echo:latest
