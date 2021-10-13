aws --region us-east-2 cloudwatch get-metric-statistics \
--metric-name Duration \
--start-time 2021-10-11T23:18:00Z \
--end-time 2021-10-13T23:18:00Z \
--period 3600 \
--namespace AWS/Lambda \
--statistics Average \
 --dimensions Name=FunctionName,Value=aws-lambda-function-cold-start-time-dev-node_handler
