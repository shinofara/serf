#!/bin/sh

DOKCER_IMAGE_NAME=shinofara/serf_nginx:latest

cmd=""
cmd="docker run -d -t \
       --name proxy \
       -p 80:80 \
       ${DOKCER_IMAGE_NAME}"

echo $cmd & $cmd

