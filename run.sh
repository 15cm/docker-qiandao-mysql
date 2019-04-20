#!/bin/bash

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

until mysql_exec ';'; do
  sleep 3
done

mysql_exec 'source /qiandao/qiandao.sql'

python /qiandao/run.py
