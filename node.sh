#!/bin/sh

num=`docker ps | grep node | wc -l`
num=`echo $num | tr -d " "`
num=$(( num+1 ))
SSH_PORT=$(( 2220 + num ))
node_name=node$num
echo $node_name


SERF_PORT=7945
DOKCER_IMAGE_NAME=shinofara/serf:latest

cmd=""
if [[ $num -eq 1 ]]; then
cmd="docker run -d -t \
       --name ${node_name} \
       -p ${SERF_PORT} \
       -p ${SSH_PORT}:22 \
       ${DOKCER_IMAGE_NAME}"
else

cmd="docker run -d -t \
       --name ${node_name} \
       -p ${SERF_PORT} \
       -p ${SSH_PORT}:22 \
       --link node1:node \
       ${DOKCER_IMAGE_NAME}" 
fi

echo $cmd && $cmd

