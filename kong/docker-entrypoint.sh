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

file_env 'KONG_PG_DATABASE'

if [[ -z "$KONG_PG_DATABASE" ]]; then
  echo >&2 'You need to specify one of KONG_PG_DATABASE or KONG_PG_DATABASE_FILE'
  exit 1
fi

file_env 'KONG_PG_USER'

if [[ -z "$KONG_PG_USER" ]]; then
  echo >&2 'You need to specify one of KONG_PG_USER or KONG_PG_USER_FILE'
  exit 1
fi

file_env 'KONG_PG_PASSWORD'

if [[ -z "$KONG_PG_PASSWORD" ]]; then
  echo >&2 'You need to specify one of KONG_PG_PASSWORD or KONG_PG_PASSWORD_FILE'
  exit 1
fi

# Register kong-admin and kong-dashboard api endpoints
# and assicotiate consumer and credentials for admin access
# exec "/setup-admin.sh"

# Disabling nginx daemon mode
export KONG_NGINX_DAEMON="off"

exec "$@"