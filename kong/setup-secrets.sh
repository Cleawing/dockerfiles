#!#!/bin/bash
set -e

# if [[ -n "$KONG_PG_DATABASE_FILE" && -f "$KONG_PG_DATABASE_FILE" ]]; then
#   export KONG_PG_DATABASE = `cat $KONG_PG_DATABASE_FILE`
# fi
#
# if [[ -n "$KONG_PG_USER_FILE" && -f "$KONG_PG_USER_FILE" ]]; then
#   export KONG_PG_USER = `cat $KONG_PG_USER_FILE`
# fi

if [[ -n "$KONG_PG_PASSWORD_FILE" && -f "$KONG_PG_PASSWORD_FILE" ]]; then
  export KONG_PG_PASSWORD = `cat $KONG_PG_PASSWORD_FILE`
fi
