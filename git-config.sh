#! /bin/bash

echo "Enter global user name for git:"
read username
git config --global user.name $username

echo "Enter global user email for git:"
read email
git config --global user.email $email

# allow caching of credentials with a 2 hour (7200 second) timeout
git config credential.helper store
git config --global credential.helper "cache --timeout 7200"