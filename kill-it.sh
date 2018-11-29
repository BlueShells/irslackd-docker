#!/bin/bash

# Stop and Remove Container
# - running this will delete the container causing SSL cert to regenerate
#   the next time the container is run.  This is not ideal.
docker kill irslackd
sleep 2
docker rm irslackd

# Kill Volume (contains cert/key only)
docker volume rm irslackdata

