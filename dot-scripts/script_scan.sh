#! /usr/bin/env bash

# Script to run clamAV on a script before running

# Usage: script_scan.sh https://some-script.sh [args for the script...]

url="$1"
shift

script_file="$(mktemp)"

cleanup() {
    echo "=================================================="
    echo "Exiting"
    rm -v "$script_file"
}

# EXIT also fires on Ctrl+C, so no separate SIGINT trap needed
trap cleanup EXIT

echo "Downloading script to temporary file: $script_file"
if ! curl -fsSL "$url" -o "$script_file"; then
    echo "Download failed, aborting."
    exit 1
fi

echo "Scanning file"
# clamscan exit codes: 0 = clean, 1 = infected, 2 = error
clamscan --no-summary "$script_file"
scan_status=$?

if [ "$scan_status" -ne 0 ]; then
    echo "Scan did not come back clean (clamscan exit $scan_status), aborting."
    exit 1
fi

read -p "Run script? [y/n]: " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then

    echo "Running $script_file"
    echo "=================================================="

    # run as its own process so its shebang is respected and an `exit`
    # in it doesn't end this script (and skip cleanup)
    chmod +x "$script_file"
    "$script_file" "$@"
fi
