#! /usr/bin/env bash
#
# Andrew Barlow
#
# Description:
# Script to disconnect idle controllers (as in gamepads, bluetoothctl calls the
# computer the "controller" bc there's no way that could be misconstrued)

# get controller address
controller="$(bluetoothctl devices | grep -i 'Wireless Controller' | awk '{print $2}')"

# disconnect controller
bluetoothctl disconnect "$controller"
# echo "$controller"
