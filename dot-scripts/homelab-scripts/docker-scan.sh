#!/bin/bash

CACHE="$HOME/docker/data/trivy/cache"
REPORT="$HOME/docker/data/trivy/scan-$(date +%Y%m%d-%H%M%S).txt"

mkdir -p "$CACHE"

docker ps --format '{{.Image}}' | sort -u | while IFS= read -r IMAGE; do

    echo
    echo "=================================================="
    echo "SCANNING: $IMAGE"
    echo "=================================================="

    docker run --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v "$CACHE:/root/.cache" \
      aquasec/trivy:latest image \
      --image-src docker \
      --scanners vuln \
      --severity HIGH,CRITICAL \
      --format table \
      "$IMAGE" || echo "ERROR scanning: $IMAGE"

done 2>&1 | tee "$REPORT"

echo "Report saved: $REPORT"
