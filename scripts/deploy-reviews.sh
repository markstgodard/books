#!/bin/bash
source $(pwd)/cf.cfg
source $(pwd)/scripts/cf.sh

cf push ${REVIEWS_NAME} -o amalgam8/a8-examples-bookinfo-reviews-sidecar:v3 --no-start --no-route -u none
cf_setenv ${REVIEWS_NAME} reviews v3 9080

cf start ${REVIEWS_NAME}

cf access-allow ${PRODUCTS_NAME} ${REVIEWS_NAME}  --port 9080 --protocol tcp
