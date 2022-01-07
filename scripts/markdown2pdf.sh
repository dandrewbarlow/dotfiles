#! /bin/bash

pandoc $1 -t pdf | open -f -a /System/Applications/Preview.App
