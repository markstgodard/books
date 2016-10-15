#!/bin/bash
source $(pwd)/cf.cfg
source $(pwd)/scripts/cf.sh

cf push ${PRODUCTS_NAME} -o amalgam8/a8-examples-bookinfo-productpage-sidecar:v1 --no-start
cf_setenv ${PRODUCTS_NAME} products v1 9080

cf start ${PRODUCTS_NAME}
