#!/bin/bash

docker run -ti --name irslackd --mount source=irslackdata,target=/config \
               -p 6697:6697    \
               -d              \
               $( whoami )/irslackd

