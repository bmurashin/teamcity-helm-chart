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
echo "Define namespaces"
echo

echo -n "    server [teamcity-server]: "
read TEAMCITY_SERVER_NAMESPACE
TEAMCITY_SERVER_NAMESPACE=${TEAMCITY_SERVER_NAMESPACE:-teamcity-server}

echo -n "    agent [teamcity-agent]: "
read TEAMCITY_AGENT_NAMESPACE
TEAMCITY_AGENT_NAMESPACE=${TEAMCITY_AGENT_NAMESPACE:-teamcity-agent}


echo
helm install teamcity . \
  --namespace "${TEAMCITY_SERVER_NAMESPACE}" \
  --create-namespace \
  --set server.admin.username="${ADMIN_USERNAME}" \
  --set server.admin.password="${ADMIN_PASSWORD}" \
  --set namespace.server="${TEAMCITY_SERVER_NAMESPACE}" \
  --set namespace.agent="${TEAMCITY_AGENT_NAMESPACE}"