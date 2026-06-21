#!/bin/bash

echo "Building Docker Image..."

docker build -t react-app:latest .

echo "Build Completed"
