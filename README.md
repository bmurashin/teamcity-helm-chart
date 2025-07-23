# TeamCity helm chart

Chart for deploying TeamCity HA server and build agents in separate namespaces

## Usage
### To install the chart:

You need to have csi-nfs (https://github.com/kubernetes-csi/csi-driver-nfs)  
and ingress-nginx (https://github.com/kubernetes/ingress-nginx) installed on your k8s cluster to use this chart directly

csi-nfs will introduce a single point of failure - for production, consider using another storage driver, capable of mounting same PV in multiple pods, like https://github.com/ceph/ceph-csi or other HA filesystem

For quick start with default settings run

```sh
./install.sh
```

If you want to customize, edit values.yaml before running `./install.sh`  
e.g. if you don't want to use ingress - set `ingress.enabled: false`

Until TC server is initialized (this will happen automatically), HAProxy at http://{{ ingress-dns-name }}/ will return `"503 Service Unavailable"` - just wait some time and refresh the page

If you don't use ingress, execute `kubectl -n teamcity-server port-forward svc/nodes2 8111` and go to http://localhost:8111/

### Build agents

You will find automatically set up and ready to run kubernetes profile in the Root project, that can be shared with any other project

For details, go to `Admin -> Projects -> Root project -> Cloud Profiles` and pick `k8s-teamcity-agent` profile

**Congrats, You're all set**

### To uninstall:

```sh
helm --namespace=teamcity-server uninstall teamcity
```