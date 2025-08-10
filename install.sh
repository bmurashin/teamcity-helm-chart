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
echo "Check dependencies"
echo

# Check if ingress-nginx is installed
if ! kubectl get ingressclasses nginx 2>/dev/null 1>/dev/null; then
  echo -n "    ingress-nginx not found, do you want to install it? [Y/n]: ";
  read INSTALL_INGRESS_NGINX
  if [ "$INSTALL_INGRESS_NGINX" = "" ] || [ "$INSTALL_INGRESS_NGINX" = "y" ] || [ "$INSTALL_INGRESS_NGINX" = "Y" ]; then
    echo "    Installing ingress-nginx..."
    helm upgrade --install ingress-nginx ingress-nginx \
      --repo https://kubernetes.github.io/ingress-nginx \
      --namespace ingress-nginx --create-namespace
  fi
else
  echo "    ingress-nginx: OK"
fi

# Check if csi-driver-nfs is installed
if ! kubectl get csidrivers nfs.csi.k8s.io 2>/dev/null 1>/dev/null; then
  echo -n "    csi-driver-nfs not found, do you want to install it? [Y/n]: ";
  read INSTALL_CSI_DRIVER_NFS
  if [ "$INSTALL_CSI_DRIVER_NFS" = "" ] || [ "$INSTALL_CSI_DRIVER_NFS" = "y" ] || [ "$INSTALL_CSI_DRIVER_NFS" = "Y" ]; then
    echo "    Installing csi-driver-nfs..."
    helm upgrade --install csi-driver-nfs csi-driver-nfs \
      --namespace kube-system --version 4.11.0 \
      --repo https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
  fi
else
  echo "    csi-driver-nfs: OK"
fi


echo
helm dependency build
helm install teamcity . \
  --namespace "${TEAMCITY_SERVER_NAMESPACE}" \
  --create-namespace \
  --set server.admin.username="${ADMIN_USERNAME}" \
  --set server.admin.password="${ADMIN_PASSWORD}" \
  --set namespace.server="${TEAMCITY_SERVER_NAMESPACE}" \
  --set namespace.agent="${TEAMCITY_AGENT_NAMESPACE}"