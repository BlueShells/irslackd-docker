#!/bin/bash

# Stop and Remove Container
docker kill irslackd
sleep 2
docker rm irslackd

# Kill Volume (contains cert/key only)
docker volume rm irslackdata

