#!/bin/bash
# Creates a Slack channel on the Trim Agency slack account
# Asks for name and if it should be private or not

# Replace with main account token
slack_token=

echo "Channel name?"
read channel_name

if [ "$channel_name" = "" ]; then
  echo "You must enter a channel name"
  invalid_arguments=1
fi

echo "Should this channel be private? (y/n)"
read private_channel

if [ "$private_channel" != "y" ] && [ "$private_channel" != "n" ]; then
  echo "You must choose either y or n"
  invalid_arguments=1
fi

if [ "$invalid_arguments" == "1" ]; then
  exit -1
fi

if [ "$private_channel" == "y" ]; then
  echo "Creating a private channle named '$channel_name' ..."
  curl "https://slack.com/api/groups.create?token=${slack_token}&pretty=1&name=${channel_name}" > /dev/null 2>&1
  echo "done."
  exit
fi

if [ "$private_channel" == "n" ]; then
  echo "Creating a team channle named '$channel_name' ..."
  curl "https://slack.com/api/channels.create?token=${slack_token}&pretty=1&name=${channel_name}" > /dev/null 2>&1
  echo "done."
  exit
fi
