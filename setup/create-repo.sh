#!/bin/bash
# Creates a github repo from the command line for Trim Agency
# To use this script you must have your github global configs
# set for user and for token. You can generate a token on github.com

echo "Repo name?"
read repo_name

if [ "$repo_name" = "" ]; then
echo "You must enter a repo name"
invalid_credentials=1
fi

username=`git config github.user`
if [ "$username" = "" ]; then
echo "Could not find username, run 'git config --global github.user <username>'"
invalid_credentials=1
fi

token=`git config github.token`
if [ "$token" = "" ]; then
echo "Could not find token, run 'git config --global github.token <token>'"
invalid_credentials=1
fi

if [ "$invalid_credentials" == "1" ]; then
exit
fi

echo -n "Creating Github repository '$repo_name' ..."
curl -u "$username:$token" https://api.github.com/orgs/trimagency/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
echo " done."

echo -n "Setting Github repository '$repo_name' to private ..."
curl --request PATCH -u "$username:$token" https://api.github.com/repos/trimagency/"$repo_name" -d '{"private":"true"}' > /dev/null 2>&1
echo " done."

echo -n "Adding Front End team to Github repository '$repo_name' ..."
curl --request PUT -u "$username:$token" https://api.github.com/teams/1238077/repos/trimagency/"$repo_name" -d '{"permission":"admin"}'
echo " done."

echo -n "Adding TeamTrim team to Github repository '$repo_name' ..."
curl --request PUT -u "$username:$token" https://api.github.com/teams/1975081/repos/trimagency/"$repo_name" -d '{"permission":"admin"}'
echo " done."
