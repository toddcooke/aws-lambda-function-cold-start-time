# AWS Lambda function cold start time

This unfinished project is to show the cold start times of various AWS Lambda function runtimes. 

The lambda functions are deployed with the serverless framework and they run once a day.

A daily github actions job will query aws for the duration of each lambda and post that to a file in the repo.

When a user visits the github pages site, eg https://toddcooke.github.io/aws-lambda-function-cold-start-time, they will see charts comparing the runtimes of lambdas.

I thought this would be useful as there are many articles comparing cold start times but those articles don't represent recent lambda performance and don't show duration over time, eg how has performance changed for python functions over the last 5 years.
