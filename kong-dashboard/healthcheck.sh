#!/bin/bash
set -e

nc -w 5 localhost 8080 </dev/null && \
  curl -s -f http://$KONG_GATEWAY_SERVICE_HOST:8001/cluster > /dev/null)
