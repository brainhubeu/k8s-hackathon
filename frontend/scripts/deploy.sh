#!/usr/bin/env bash

set -e

export REACT_APP_CONTENT_API_URL=https://conduit.productionready.io/api
export KEYCLOAK_URL=http://keycloak:8080
export KEYCLOAK_REALM_NAME=conduit
export KEYCLOAK_ADMIN_CLIENT_ID=users-api
export KEYCLOAK_ADMIN_CLIENT_SECRET=cebf2185-5a86-4cc2-b391-685e04cd6117

#yarn run build

cd ./build

aws s3 sync --delete ./static s3://www.k8s-hackathon.brainhub.pl/static --cache-control "max-age=2628000,public"
aws s3 sync --delete --exclude "static/*" . s3://www.k8s-hackathon.brainhub.pl --cache-control "public,must-revalidate,proxy-revalidate,max-age=0"
