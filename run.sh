#!/bin/bash

# Env used by qiandao/config.py for database connections
export JAWSDB_MARIA_URL="http://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"

# Create tables if not exists. Won't overwrite tables if exists

mysql_exec() {
  command=$1
  mysql -s \
        -h ${MYSQL_HOST} -P ${MYSQL_PORT} \
        -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} \
        -e "${command}" \
        ${MYSQL_DATABASE}
}

# Use /wait-for-it.sh in docker-compose to wait for database
mysql_exec 'source /qiandao/qiandao.sql'

# App entry
/qiandao/run.py
