# TeamCity helm chart

Chart for deploying TeamCity HA server and build agents in separate namespaces

## Usage
### To install the chart:

You need to have csi-nfs (https://github.com/kubernetes-csi/csi-driver-nfs)  
and ingress-nginx (https://github.com/kubernetes/ingress-nginx) installed on your k8s cluster to use this chart directly

csi-nfs will introduce a single point of failure - for production, consider using another storage driver, capable of mounting same PV in multiple pods, like https://github.com/ceph/ceph-csi or other HA filesystem

If you don't want ingress - set `ingress.enabled: false` in values.yaml

Edit values.yaml to your favor and

```sh
helm install teamcity-helm-chart .
```

To initialize the main node, execute `kubectl -n teamcity-server port-forward server-0 8111` and go to http://localhost:8111/

After that TeamCity cluster can be access using HAProxy at http://{{ ingress-dns-name }}/  
If that doesn't work, use `kubectl -n teamcity-server port-forward svc/nodes2 8111` and go to http://localhost:8111/

### To setup build agents

Go to `Admin -> Projects -> Root project -> Cloud Profiles -> Create new profile -> Kubernetes Agents` (Don't confuse with _agentless kubernetes_ option)

| Field | Value |
|-|-|
| Server URL: | http://haproxy.teamcity-server.svc.cluster.local |
| Kubernetes API server URL: | e.g. https://kubernetes.docker.internal:6443 - find your URL using `kubectl config view` |
| Kubernetes namespace: | teamcity-agent |
| Authentication strategy: | Token |
| Token: | get token using `kubectl -n teamcity-agent get secret teamcity-secret -o=jsonpath='{.data.token}' \| base64 --decode` |

Press `Add image`
| Field | Value |
|-|-|
| Pod specification: | Use pod template from deployment |
| Deployment name: | teamcity-agent |
| Agent pool: | Default |

Press `Create` - soon you'll see `1 running` agent

**Congrats, You're all set**

### To uninstall:

```sh
helm uninstall teamcity-helm-chart
```