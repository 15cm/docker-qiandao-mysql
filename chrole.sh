#!/bin/bash

# Env used by qiandao/config.py for database connections
export JAWSDB_MARIA_URL="http://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"

/qiandao/chrole.py $@
