#!/bin/bash

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_DATABASE=${MYSQL_DATABASE:-qiandao}
MYSQL_USER=${MYSQL_USER:-qiandao}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-qiandao}

export JAWSDB_MARIA_URL="http://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"

# Create tables if not exists. Won't overwrite tables if exists
mysql -h ${MYSQL_HOST} -P ${MYSQL_PORT} \
      -u ${MYSQL_USER} -p ${MYSQL_PASSWORD} \
      -e "source /qiandao/qiandao.sql" \
      ${MYSQL_DATABASE}

python /qiandao/run.py
