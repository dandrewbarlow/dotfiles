#! /bin/bash

ticker=1

while [ $ticker -lt 100 ]; do
	./randomWallpaper.sh
	let ticker=ticker+1
done
