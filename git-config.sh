#! /bin/bash

echo "Enter global user name for git:"
read username
git config --global user.name $username

echo "Enter global user email for git:"
read email
git config --global user.email $email
