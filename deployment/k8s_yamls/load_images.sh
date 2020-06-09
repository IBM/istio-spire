#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$DIR/../../bin

kind load docker-image webecho_web:latest
kind load docker-image webecho_echo:latest
