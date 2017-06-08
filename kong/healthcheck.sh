#!/bin/bash
set -e

nc -w 5 $KONG_PG_HOST $KONG_PG_PORT < /dev/null && \
  nc -w 5 localhost 8000 </dev/null && \
  curl -s -f http://localhost:8001/cluster > /dev/null
