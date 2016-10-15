#!/bin/bash

source $(pwd)/cf.cfg

cf push ${DETAILS_NAME} -o amalgam8/a8-examples-bookinfo-details-sidecar:v1 --no-start --no-route

cf set-env ${DETAILS_NAME} A8_SERVICE "details:v1"
cf set-env ${DETAILS_NAME} A8_ENDPOINT_PORT "9080"
cf set-env ${DETAILS_NAME} A8_ENDPOINT_TYPE "http"
cf set-env ${DETAILS_NAME} A8_PROXY "true"
cf set-env ${DETAILS_NAME} A8_REGISTER "true"
cf set-env ${DETAILS_NAME} A8_REGISTRY_URL "http://${REGISTRY_NAME}.bosh-lite.com"
cf set-env ${DETAILS_NAME} A8_CONTROLLER_URL "http://${CONTROLLER_NAME}.bosh-lite.com"

cf start ${DETAILS_NAME}

cf access-allow ${PRODUCTS_NAME} ${DETAILS_NAME}  --port 9080 --protocol tcp
