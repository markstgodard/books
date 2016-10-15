#!/bin/bash
source $(pwd)/cf.cfg
source $(pwd)/scripts/cf.sh

cf push ${DETAILS_NAME} -o amalgam8/a8-examples-bookinfo-details-sidecar:v1 --no-start --no-route
cf_setenv ${DETAILS_NAME} details v1 9080

cf start ${DETAILS_NAME}

cf access-allow ${PRODUCTS_NAME} ${DETAILS_NAME}  --port 9080 --protocol tcp
