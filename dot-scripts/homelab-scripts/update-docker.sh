#! /usr/bin/env bash
# script to update my docker services

stack_dir="$HOME/stacks"

for stack in "$stack_dir"/*; do
  pushd "$stack" > /dev/null
  echo "Updating $stack"
  docker compose stop
  docker compose pull
  docker compose up -d
  popd > /dev/null
done

