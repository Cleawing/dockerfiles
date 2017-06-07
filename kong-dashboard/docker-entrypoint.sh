#!/usr/local/bin/dumb-init /bin/bash
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

file_env 'KONG_DASHBOARD_ADMIN_NAME'

if [[ -z "$KONG_DASHBOARD_ADMIN_NAME" ]]; then
  echo >&2 'You need to specify one of KONG_DASHBOARD_ADMIN_NAME or KONG_DASHBOARD_ADMIN_NAME_FILE'
  exit 1
fi

export kong-dashboard-name="$KONG_DASHBOARD_ADMIN_NAME"

file_env 'KONG_DASHBOARD_ADMIN_PASSWORD'

if [[ -z "$KONG_DASHBOARD_ADMIN_PASSWORD" ]]; then
  echo >&2 'You need to specify one of KONG_DASHBOARD_ADMIN_PASSWORD or KONG_DASHBOARD_ADMIN_PASSWORD_FILE'
  exit 1
fi

export kong-dashboard-pass="$KONG_DASHBOARD_ADMIN_PASSWORD"

npm run start -- $@
