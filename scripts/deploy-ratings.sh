#!/bin/bash
source $(pwd)/cf.cfg
source $(pwd)/scripts/cf.sh

cf push ${RATINGS_NAME} -o amalgam8/a8-examples-bookinfo-ratings-sidecar:v1 --no-start --no-route
cf_setenv ${RATINGS_NAME} ratings v1 9080

cf start ${RATINGS_NAME}

cf access-allow ${REVIEWS_NAME} ${RATINGS_NAME}  --port 9080 --protocol tcp
