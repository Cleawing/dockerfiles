#!/bin/bash
set -e

while ! curl -s -f http://gateway:8001/cluster > /dev/null
do
  sleep 1
done

if [ $(curl -s http://gateway:8001/apis/kong-dashboard | jq -r '.name') = 'null' ]; then
  curl -s -i -X POST --url http://gateway:8001/apis --data 'name=kong-dashboard' --data "hosts=$KONG_DASHBOARD_HOST" --data 'upstream_url=http://dashboard:8080' > /dev/null
fi
