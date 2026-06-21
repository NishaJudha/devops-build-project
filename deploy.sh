#!/bin/bash

echo "Deploying Application..."

docker stop react-app || true

sleep 5

docker rm -f react-app || true

docker run -d \
  --name react-app \
  -p 80:80 \
  react-app:latest

echo "Deployment Complete"
