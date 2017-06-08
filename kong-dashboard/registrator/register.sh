#!/bin/bash
set -e

while ! curl -s -f http://$KONG_GATEWAY_SERVICE_HOST:8001/cluster > /dev/null
do
  sleep 1
done

if [ $(curl -s http://$KONG_GATEWAY_SERVICE_HOST:8001/apis/kong-dashboard | jq -r '.name') = 'null' ]; then
  curl -s -i -X POST --url http://$KONG_GATEWAY_SERVICE_HOST:8001/apis --data 'name=kong-dashboard' --data "hosts=$KONG_DASHBOARD_EXTERNAL_HOST" --data "upstream_url=http://$KONG_DASHBOARD_SERVICE_HOST:8080" > /dev/null
fi
