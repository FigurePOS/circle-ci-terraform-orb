#!/bin/bash

if [ -z "$CIRCLE_API_TOKEN" ]
then
      echo "CIRCLE_API_TOKEN variable is empty"
      exit 1
fi

if [ -z "$CIRCLE_WORKFLOW_ID" ]
then
      echo "CIRCLE_WORKFLOW_ID variable is empty"
      exit 1
fi

if [ -z "$ENV" ]
then
      echo "ENV variable is empty"
      exit 1
fi


if [[ $(cat /tmp/workspace/"$ENV"-tfplan.change) != "true" ]];
then
    echo "No changes in the plan. Canceling.."
    curl --request POST \
        --url https://circleci.com/api/v2/workflow/"$CIRCLE_WORKFLOW_ID"/cancel \
        --header "Circle-Token: ${CIRCLE_API_TOKEN}"
else
    echo "Changes in the plan detected. Proceeding.."
fi