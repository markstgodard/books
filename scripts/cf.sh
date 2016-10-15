cf_setenv() {
  local app=$1
  local service_name=$2
  local ver=$3
  local port=$4
  cf set-env ${app} A8_SERVICE "${service_name}:${ver}"
  cf set-env ${app} A8_ENDPOINT_PORT "${port}"
  cf set-env ${app} A8_ENDPOINT_TYPE "http"
  cf set-env ${app} A8_PROXY "true"
  cf set-env ${app} A8_REGISTER "true"
  cf set-env ${app} A8_REGISTRY_URL "http://${REGISTRY_NAME}.${ROUTES_DOMAIN}"
  cf set-env ${app} A8_CONTROLLER_URL "http://${CONTROLLER_NAME}.${ROUTES_DOMAIN}"
}

