#!/bin/bash

ROOT_PATH=$(dirname "$0")
if [ ! -f $ROOT_PATH/domains.list ]; then
    echo "$ROOT_PATH/domains.list File not found!"
    exit 0
fi

if [ ! -f $ROOT_PATH/nginx.template ]; then
    echo "$ROOT_PATH/nginx.template File not found!"
    exit 0
fi

echo "$(date) STARTED"
mkdir -p $ROOT_PATH/sites-avaliable $ROOT_PATH/sites-enabled

KEYWORD="example.com"

for DOMAIN_NAME in $(cat $ROOT_PATH/domains.list); do
    sed "s/${KEYWORD}/${DOMAIN_NAME}/g;" $ROOT_PATH/nginx.template > $ROOT_PATH/sites-avaliable/$DOMAIN_NAME.conf
    ln -sf ../sites-avaliable/$DOMAIN_NAME.conf $ROOT_PATH/sites-enabled/$DOMAIN_NAME.conf
done

echo "$(date) FINISHED"