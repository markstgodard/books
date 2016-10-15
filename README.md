# About
Books is a micro-services application that uses CF Container Networking

# Prerequisites
- CF
- Diego w/ docker support enabled
- Netman support

# Steps

## Install Amalgam8 Controller and Registry
```
./scripts/deploy-a8.sh
```

You should now see the amalgam8 controller and registry apps running:
```
$ cf apps
Getting apps in org demo / space demo as admin...
OK

name               requested state   instances   memory   disk   urls
books-controller   started           1/1         256M     1G     books-controller.bosh-lite.com
books-registry     started           1/1         256M     1G     books-registry.bosh-lite.com
```
