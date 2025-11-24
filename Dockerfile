FROM nginx:alpine

# tools: envsubst (gettext) y openssl para htpasswd
RUN apk add --no-cache gettext openssl

# usamos plantilla y entrypoint
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
