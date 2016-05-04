#!/bin/sh
set -u

if [ -z "${NODE_PORT_7946_TCP_ADDR+x}" ]; then
    serf agent -bind 0.0.0.0:7946
else
    serf agent -bind 0.0.0.0:7946 -join $NODE_PORT_7946_TCP_ADDR:7946
fi
