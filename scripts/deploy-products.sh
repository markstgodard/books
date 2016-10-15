#!/bin/bash

source $(pwd)/cf.cfg

cf push ${PRODUCTS_NAME} -o amalgam8/a8-examples-bookinfo-productpage-sidecar:v1 --no-start

cf set-env ${PRODUCTS_NAME} A8_SERVICE "products:v1"
cf set-env ${PRODUCTS_NAME} A8_ENDPOINT_PORT "9080"
cf set-env ${PRODUCTS_NAME} A8_ENDPOINT_TYPE "http"
cf set-env ${PRODUCTS_NAME} A8_PROXY "true"
cf set-env ${PRODUCTS_NAME} A8_REGISTER "true"
cf set-env ${PRODUCTS_NAME} A8_REGISTRY_URL "http://${REGISTRY_NAME}.${ROUTES_DOMAIN}"
cf set-env ${PRODUCTS_NAME} A8_CONTROLLER_URL "http://${CONTROLLER_NAME}.${ROUTES_DOMAIN}"

cf start ${PRODUCTS_NAME}
