#!/bin/bash
set -e

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'KONG_DASHBOARD_NAME'

if [[ -z "$KONG_DASHBOARD_NAME" ]]; then
  echo >&2 'You need to specify one of KONG_DASHBOARD_NAME or KONG_DASHBOARD_NAME_FILE'
  exit 1
fi

file_env 'KONG_DASHBOARD_PASS'

if [[ -z "$KONG_DASHBOARD_PASS" ]]; then
  echo >&2 'You need to specify one of KONG_DASHBOARD_PASS or KONG_DASHBOARD_PASS_FILE'
  exit 1
fi

curl -s -f http://$KONG_DASHBOARD_NAME:$KONG_DASHBOARD_PASS@localhost:8080 > /dev/null </dev/null && \
  curl -s -f http://$KONG_GATEWAY_SERVICE_HOST:8001/cluster > /dev/null
