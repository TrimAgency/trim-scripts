# Trim Agency Automation Scripts

This is a collection of scripts that help to automate common tasks performed at Trim Agency.

## Setup

### create-repo.sh

This script creates a new repository on the Trim Agency GitHub organization.
It asks for the name of the repo and then creates it, sets it to private, and adds the team as an admin.
You must have your git global config set for user and for token.  You can generate a new token in your user
settings on GitHub.

Run the script with the following command:
```
./setup/create-repo.sh
```
