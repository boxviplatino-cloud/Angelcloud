#!/bin/sh
set -e

# Valores por defecto (si no los defines en Cloud Run)
: "${UPSTREAM_HOST:=127.0.0.1}"
: "${UPSTREAM_PORT:=80}"
: "${BASIC_USER:=guest}"
: "${BASIC_PASS:=guest}"

# Crear archivo htpasswd (openssl ya está en la imagen)
printf "%s:%s\n" "$BASIC_USER" "$(openssl passwd -apr1 "$BASIC_PASS")" > /etc/nginx/.htpasswd

# Sustituir variables UPSTREAM en la plantilla de nginx
envsubst '${UPSTREAM_HOST} ${UPSTREAM_PORT}' \
  < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Arrancar nginx en primer plano
nginx -g 'daemon off;'
