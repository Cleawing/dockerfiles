#!/bin/bash
set -e

nc -w 5 $KONG_PG_HOST $KONG_PG_PORT < /dev/null && curl -s -f http://localhost:8001/cluster > /dev/null
