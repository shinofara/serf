#!/bin/sh

num=`docker ps | grep node | wc -l`
num=`echo $num | tr -d " "`
num=$(( num+1 ))
node_name=node$num
echo $node_name

DOKCER_IMAGE_NAME=shinofara/serf_app:latest

cmd="docker run -d -t \
       --name ${node_name} \
       --link proxy:node \
       -h ${node_name} \
       ${DOKCER_IMAGE_NAME}" 

echo $cmd && $cmd

