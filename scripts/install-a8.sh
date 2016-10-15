#!/bin/bash
A8_DIR=vendor/github.com/amalgam8/amalgam8

CONTROLLER_NAME=books-controller
REGISTRY_NAME=books-registry


mkdir -p bin/controller
mkdir -p bin/registry

cp $A8_DIR/controller/schema.json bin/controller

# build controller and registry
pushd $A8_DIR
  GOOS=linux GOARCH=amd64 make
popd

# deploy controller
cp $A8_DIR/bin/a8controller bin/controller
cf push $CONTROLLER_NAME -p bin/controller -c './a8controller' -b binary_buildpack

# deploy registry
cp $A8_DIR/bin/a8registry bin/registry
cf push $REGISTRY_NAME -p bin/registry -c './a8registry' -b binary_buildpack
