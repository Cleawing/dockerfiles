FROM pgbi/kong-dashboard:v2.1.1

RUN apk update && apk add curl jq bash
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY server.js ./bin/server.js

ENTRYPOINT ["/docker-entrypoint.sh"]
