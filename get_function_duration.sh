#!/usr/bin/env bash
set -e

# USAGE
# bash get_function_duration

function getFunctionDuration() {
TODAY=$(date +%F)
LAST_WEEK=$([ "$OSTYPE" = linux-gnu ] && date --date="7 days ago" +"%Y"."%m"."%d" || date -v-7d +"%Y"."%m"."%d")

aws --region us-east-2 cloudwatch get-metric-statistics \
--metric-name Duration \
--start-time ${LAST_WEEK}T00:00:00Z \
--end-time ${TODAY}T00:00:00Z \
--period 3600 \
--namespace AWS/Lambda \
--statistics Average \
--dimensions Name=FunctionName,Value="$1"
}

PYTHON_LAMBDA_METRICS=$(getFunctionDuration "aws-lambda-function-cold-start-time-dev-python_handler")
NODE_LAMBDA_METRICS=$(getFunctionDuration "aws-lambda-function-cold-start-time-dev-node_handler")

PYTHON_LAMBDA_DATES=$(echo "$PYTHON_LAMBDA_METRICS" | \
jq -r '.Datapoints[] | .Timestamp' | \
awk 'BEGIN { FS = "T" }{ print $1 }' | \
sort | uniq)

NODE_LAMBDA_DATES=$(echo "$NODE_LAMBDA_METRICS" | \
jq -r '.Datapoints[] | .Timestamp' | \
awk 'BEGIN { FS = "T" }{ print $1 }' | \
sort | uniq)

COMMON_DATES=$(comm -1 -2 <(echo "$PYTHON_LAMBDA_DATES") <(echo "$NODE_LAMBDA_DATES"))
#echo $COMMON_DATES

#echo "$DURATION" | jq '.Datapoints' > "data/$FUNCTION_NAME.json"

# For each date in json
for _date in $COMMON_DATES; do
  echo "$_date"
#  TODO: write json like [[date,python_duration,nodejs_duration],[etc]]
  JSON='['
  JSON+='[]'
done
