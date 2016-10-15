#!/bin/bash

source $(pwd)/cf.cfg

cf push ${RATINGS_NAME} -o amalgam8/a8-examples-bookinfo-ratings-sidecar:v1 --no-start --no-route

cf set-env ${RATINGS_NAME} A8_SERVICE "ratings:v1"
cf set-env ${RATINGS_NAME} A8_ENDPOINT_PORT "9080"
cf set-env ${RATINGS_NAME} A8_ENDPOINT_TYPE "http"
cf set-env ${RATINGS_NAME} A8_PROXY "true"
cf set-env ${RATINGS_NAME} A8_REGISTER "true"
cf set-env ${RATINGS_NAME} A8_REGISTRY_URL "http://${REGISTRY_NAME}.bosh-lite.com"
cf set-env ${RATINGS_NAME} A8_CONTROLLER_URL "http://${CONTROLLER_NAME}.bosh-lite.com"

cf start ${RATINGS_NAME}

cf access-allow ${REVIEWS_NAME} ${RATINGS_NAME}  --port 9080 --protocol tcp
