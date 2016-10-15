#!/bin/bash
source $(pwd)/cf.cfg

cf push ${REVIEWS_NAME} -o amalgam8/a8-examples-bookinfo-reviews-sidecar:v3 --no-start --no-route -u none

cf set-env ${REVIEWS_NAME} A8_SERVICE "reviews:v3"
cf set-env ${REVIEWS_NAME} A8_ENDPOINT_PORT "9080"
cf set-env ${REVIEWS_NAME} A8_ENDPOINT_TYPE "http"
cf set-env ${REVIEWS_NAME} A8_PROXY "true"
cf set-env ${REVIEWS_NAME} A8_REGISTER "true"
cf set-env ${REVIEWS_NAME} A8_REGISTRY_URL "http://${REGISTRY_NAME}.${ROUTES_DOMAIN}"
cf set-env ${REVIEWS_NAME} A8_CONTROLLER_URL "http://${CONTROLLER_NAME}.${ROUTES_DOMAIN}"

cf start ${REVIEWS_NAME}

cf access-allow ${PRODUCTS_NAME} ${REVIEWS_NAME}  --port 9080 --protocol tcp
