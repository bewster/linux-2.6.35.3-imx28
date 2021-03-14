#!/bin/bash

cd "$(dirname "$0")"

# Save the build output to a log file
./create-image 2>&1 | tee buildlog.txt
