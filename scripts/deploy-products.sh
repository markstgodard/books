#!/bin/bash

source $SCRIPTDIR/cf.cfg

cf push products -o amalgam8/a8-examples-bookinfo-productpage-sidecar --no-start

cf set-env products A8_SERVICE "products:v1"
cf set-env products A8_ENDPOINT_PORT "8080"
cf set-env products A8_ENDPOINT_TYPE "http"
cf set-env products A8_PROXY "true"
cf set-env products A8_REGISTER "true"
cf set-env products A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env products A8_CONTROLLER_URL "http://controller.bosh-lite.com"


