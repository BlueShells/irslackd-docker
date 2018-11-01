#!/bin/bash
#
# Bootstrap to either install, or start server.
#

if [ ! -w /config ]; then
  echo "/config is not writable.  Volume not set correctly."
  exit
fi




# TODO: look for env variable for clean start


# TODO: look for an env variable to "git pull" an update


cd /config

# program doesn't exist?
if [ ! -d irslackd ]; then

  git clone https://github.com/adsr/irslackd.git
  cd irslackd
  npm install

fi


# cert doesn't exist?

if [ ! -e /config/cert.pem -o ! -e /config/pkey.pem ]; then

  # Cut and paste from ./bin/create_tls_key.sh, with default
  # parameters so as to run non-interactively

  cd /config
  echo Creating default SSL cert/key
  openssl req -newkey rsa:4096 -nodes -sha512 -x509 -days 3650 -nodes -out ./cert.pem -keyout ./pkey.pem -subj "/C=US/ST=NC/L=Some Town/O=Red Hat/CN=localhost"

  # Show fingerprint
  openssl x509 -noout -fingerprint -sha512 -inform pem -in ./cert.pem

fi



# Run it
cd /config/irslackd
./irslackd -k /config/pkey.pem -c /config/cert.pem -a 0.0.0.0



