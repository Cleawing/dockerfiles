FROM pgbi/kong-dashboard:v2.1.1

RUN apk --no-cache add bash curl
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY server.js ./bin/server.js
COPY healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

HEALTHCHECK --interval=5s --timeout=5s --retries=3 \
  CMD /healthcheck.sh || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
