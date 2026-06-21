#!/bin/bash

echo "Deploying Application..."

docker stop react-app || true

docker rm react-app || true

docker run -d \
--name react-app \
-p 80:80 \
react-app:latest

echo "Deployment Complete"
