#! /usr/bin/env bash

sudo apt update && sudo apt upgrade

sudo apt install unattended-upgrades

sudo systemctl start unattended-upgrades

sudo systemctl enable unattended-upgrades
