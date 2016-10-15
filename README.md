# About
Books is a microservices-based application that shows how CF Container Networking

# Prerequisites
- [CF](https://github.com/cloudfoundry/cf-release) deployment
- [Diego](https://github.com/cloudfoundry/diego-release) deployment
  - [Docker support](https://github.com/cloudfoundry/diego-design-notes/blob/master/docker-support.md) enabled
  - Netman support enabled
- cf cli
  - netman cf cli plugin installed

# Steps

## Deploy Amalgam8 Controller and Registry
```sh
./scripts/deploy-a8.sh
```

You should now see the amalgam8 controller and registry apps running:
```sh
$ cf apps
Getting apps in org demo / space demo as admin...
OK

name               requested state   instances   memory   disk   urls
books-controller   started           1/1         256M     1G     books-controller.bosh-lite.com
books-registry     started           1/1         256M     1G     books-registry.bosh-lite.com
```


## Deploy Products app

You may either run this script:
```sh
./scripts/deploy-products.sh
```

OR if you wish to deploy by hand
```sh
cf push books-products -o amalgam8/a8-examples-bookinfo-productpage-sidecar:v1 --no-start
cf set-env books-products A8_SERVICE "products:v1"
cf set-env books-products A8_ENDPOINT_PORT "9080"
cf set-env books-products A8_ENDPOINT_TYPE "http"
cf set-env books-products A8_PROXY "true"
cf set-env books-products A8_REGISTER "true"
cf set-env books-products A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env books-products A8_CONTROLLER_URL "http://controller.bosh-lite.com"
cf start books-products
```

## Deploy Book Details app

You may either run this script:
```sh
./scripts/deploy-details.sh
```

OR if you wish to deploy by hand
```sh
cf push books-details -o amalgam8/a8-examples-bookinfo-details-sidecar:v1 --no-start --no-route
cf set-env books-details A8_SERVICE "details:v1"
cf set-env books-details A8_ENDPOINT_PORT "9080"
cf set-env books-details A8_ENDPOINT_TYPE "http"
cf set-env books-details A8_PROXY "true"
cf set-env books-details A8_REGISTER "true"
cf set-env books-details A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env books-details A8_CONTROLLER_URL "http://controller.bosh-lite.com"
cf start books-details
```

Allow the Products app the ability to talk to the Details app:
```sh
cf access-allow books-products books-details --port 9080 --protocol tcp
```

## Deploy Book Reviews app

You may either run this script:
```sh
./scripts/deploy-reviews.sh
```

OR if you wish to deploy by hand
```sh
cf push books-reviews -o amalgam8/a8-examples-bookinfo-reviews-sidecar:v3 --no-start --no-route -u none
cf set-env books-reviews A8_SERVICE "reviews:v333"
cf set-env books-reviews A8_ENDPOINT_PORT "9080"
cf set-env books-reviews A8_ENDPOINT_TYPE "http"
cf set-env books-reviews A8_PROXY "true"
cf set-env books-reviews A8_REGISTER "true"
cf set-env books-reviews A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env books-reviews A8_CONTROLLER_URL "http://controller.bosh-lite.com"
cf start books-reviews
```

Allow the Products app the ability to talk to the Reviews app:
```sh
cf access-allow books-products books-reviews --port 9080 --protocol tcp
```

## Deploy Book Ratings app

You may either run this script:
```sh
./scripts/deploy-ratings.sh
```

OR if you wish to deploy by hand
```sh
cf push books-ratings-o amalgam8/a8-examples-bookinfo-ratings-sidecar:v1 --no-start --no-route
cf set-env books-ratings A8_SERVICE "ratings:v1"
cf set-env books-ratings A8_ENDPOINT_PORT "9080"
cf set-env books-ratings A8_ENDPOINT_TYPE "http"
cf set-env books-ratings A8_PROXY "true"
cf set-env books-ratings A8_REGISTER "true"
cf set-env books-ratings A8_REGISTRY_URL "http://registry.bosh-lite.com"
cf set-env books-ratings A8_CONTROLLER_URL "http://controller.bosh-lite.com"
cf start books-ratings
```

Allow the Products app the ability to talk to the Reviews app:
```sh
cf access-allow books-reviews books-ratings --port 9080 --protocol tcp
```

## Check Apps

```sh
$ cf apps
Getting apps in org demo / space demo as admin...
OK

name               requested state   instances   memory   disk   urls
books-controller   started           1/1         256M     1G     books-controller.bosh-lite.com
books-details      started           1/1         256M     1G
books-ratings      started           1/1         256M     1G
books-reviews      started           1/1         256M     1G
books-registry     started           1/1         256M     1G     books-registry.bosh-lite.com
books-products     started           1/1         256M     1G     books-products.bosh-lite.com
```

## Check Service Registry

At this point we have our apps deployed and we should be able to see them registered in the A8 service registry. The IP address and port that the applications register themselves under is it's CF Container Networking overlay address.

```sh
curl -s books-registry.bosh-lite.com/api/v1/instances | jq .
```

```json
{
  "instances": [
    {
      "id": "cb629d65dfc6f1e0",
      "service_name": "reviews",
      "endpoint": {
        "type": "http",
        "value": "10.255.96.22:9080"
      },
      "ttl": 60,
      "status": "UP",
      "last_heartbeat": "2016-10-15T16:03:39.428654742Z",
      "tags": [
        "v3"
      ]
    },
    {
      "id": "7306c32374223fc4",
      "service_name": "ratings",
      "endpoint": {
        "type": "http",
        "value": "10.255.12.33:9080"
      },
      "ttl": 60,
      "status": "UP",
      "last_heartbeat": "2016-10-15T16:03:41.600206818Z",
      "tags": [
        "v1"
      ]
    },
    {
      "id": "a3434e01df042473",
      "service_name": "products",
      "endpoint": {
        "type": "http",
        "value": "10.255.12.18:9080"
      },
      "ttl": 60,
      "status": "UP",
      "last_heartbeat": "2016-10-15T16:03:37.301438833Z",
      "tags": [
        "v1"
      ]
    },
    {
      "id": "8248bf8cd5d514fe",
      "service_name": "details",
      "endpoint": {
        "type": "http",
        "value": "10.255.96.16:9080"
      },
      "ttl": 60,
      "status": "UP",
      "last_heartbeat": "2016-10-15T16:03:40.571665858Z",
      "tags": [
        "v1"
      ]
    }
  ]
}
```
