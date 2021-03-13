#!/bin/bash

cd /workspace

# Save the build output to a log file
docker/build-kernel.sh 2>&1 | tee docker/buildlog.txt
