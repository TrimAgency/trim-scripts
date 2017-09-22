#!/bin/bash
# Creates an Asana board on the Product team for Trim Agency
# It then adds the default columns for a project
# Must add the Asana access token that can be generated from your profile settings

access_token=
workspace_id=285734793289376
team_id=285734793289378

echo "Board name?"
read board_name

if [ "$board_name" = "" ]; then
  echo "You must enter a board name"
  exit -1
fi

echo -n "Creating Asana board named '$board_name' ..."
project_output=$(curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects --data-urlencode "name=$board_name" --data-urlencode "workspace=$workspace_id" --data-urlencode "team=$team_id" --data-urlencode "layout=board")
echo " done."

echo "$project_output"

echo "Please enter the id from the above output."
read project_id

if [ "$project_id" = "" ]; then
  echo "You must enter a project id"
  exit -1
fi

echo -n "Creating board columns ..."
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=Reference" > /dev/null 2>&1
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=Backlog" > /dev/null 2>&1
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=Next Sprint" > /dev/null 2>&1
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=This Sprint" > /dev/null 2>&1
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=QA" > /dev/null 2>&1
curl -H "Authorization: Bearer $access_token" https://app.asana.com/api/1.0/projects/"$project_id"/sections --data-urlencode "name=Done" > /dev/null 2>&1
echo " done."
