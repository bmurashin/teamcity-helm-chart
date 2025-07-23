#!/bin/sh

set -e


echo "Define credentials for TeamCity admin user"
echo

echo -n "    admin username [admin]: "
read ADMIN_USERNAME
ADMIN_USERNAME=${ADMIN_USERNAME:-admin}


echo -n "    admin password: "
# pure sh read doesn't have -s option, use stty to disable displaying input
stty -echo
read -r ADMIN_PASSWORD
stty echo

echo
echo -n "    confirm password: "
stty -echo
read -r ADMIN_PASSWORD_CONFIRM
stty echo
echo

if [ "$ADMIN_PASSWORD" != "$ADMIN_PASSWORD_CONFIRM" ]; then
  echo
  echo "ERROR: Passwords do not match"
  exit 1
fi

if [ "$ADMIN_PASSWORD" = "" ]; then
  echo
  echo "ERROR: Password cannot be empty"
  exit 1
fi

echo
helm install teamcity . \
  --set server.admin.username="${ADMIN_USERNAME}" \
  --set server.admin.password="${ADMIN_PASSWORD}"