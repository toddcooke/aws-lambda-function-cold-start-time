#!/usr/bin/env bash
set -e

# USAGE
# bash get_function_duration <FUNCTION_NAME>

TODAY=$(date +%F)
TOMORROW=$(date -v +1d +%F)
FUNCTION_NAME="$1"

DURATION=$(aws --region us-east-2 cloudwatch get-metric-statistics \
--metric-name Duration \
--start-time ${TODAY}T00:00:00Z \
--end-time ${TOMORROW}T00:00:00Z \
--period 3600 \
--namespace AWS/Lambda \
--statistics Average \
--dimensions Name=FunctionName,Value="$1")

echo "$DURATION" | jq '.Datapoints' > "data/$FUNCTION_NAME.json"