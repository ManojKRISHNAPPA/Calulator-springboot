#!/bin/bash

dockerImageName=$(awk 'NR==1 {print $2}' Dockerfile)
echo "Scanning image: $dockerImageName"

TRIVY_IMAGE="aquasec/trivy:0.65.0"


docker run --rm \
  -v $WORKSPACE:/root/.cache/ \
  $TRIVY_IMAGE image --exit-code 0 --severity HIGH $dockerImageName

docker run --rm \
  -v $WORKSPACE:/root/.cache/ \
  $TRIVY_IMAGE image --exit-code 1 --severity CRITICAL $dockerImageName

exit_code=$?
echo "Exit Code : $exit_code"

if [[ "${exit_code}" == 1 ]]; then
    echo "Image scanning failed. Vulnerabilities found"
    exit 1
else
    echo "Image scanning passed. No CRITICAL vulnerabilities found"
fi
