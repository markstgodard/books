# About
Books is a micro-services application that uses CF Container Networking

# Prerequisites
- CF
- Diego w/ docker support enabled
- Netman support

# Steps

## Deploy Amalgam8 Controller and Registry
```
./scripts/deploy-a8.sh
```

You should now see the amalgam8 controller and registry apps running:
```
$ cf apps
Getting apps in org demo / space demo as admin...
OK

name               requested state   instances   memory   disk   urls
controller   started           1/1         256M     1G     controller.bosh-lite.com
registry     started           1/1         256M     1G     registry.bosh-lite.com
```


## Deploy Products app

You may either run this script:
```
./scripts/deploy-products.sh
```

OR if you wish to deploy by hand
```
cf push products -o amalgam8/a8-examples-bookinfo-productpage-sidecar:v1 --no-start
cf set-env products A8_SERVICE "products:v1"
cf set-env products A8_ENDPOINT_PORT "9080"
cf set-env products A8_ENDPOINT_TYPE "http"
cf set-env products A8_PROXY "true"
cf set-env products A8_REGISTER "true"
cf set-env products A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env products A8_CONTROLLER_URL "http://controller.bosh-lite.com"
cf start products
```
