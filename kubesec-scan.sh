#!/bin/bash

# kubesec-scan.sh

# Call kubesec once and store result
scan_result=$(curl -sSX POST --data-binary @"Deployment.yml" https://v2.kubesec.io/scan)

# Extract score and message
scan_message=$(echo "$scan_result" | jq -r '.[0].message')
scan_score=$(echo "$scan_result" | jq '.[0].score')

# Show score
echo "Scan Score : $scan_score"

# Kubesec scan result processing
if [[ "$scan_score" -le 5 ]]; then
    echo "Kubesec Scan Failed: $scan_message"
    exit 1
else
    echo "Kubesec Scan Passed: $scan_message"
    exit 0
fi
