# teamcity-helm-chart

Chart for deploying TeamCity HA server and build agents in separate namespaces

## Files
- `Chart.yaml`: Chart metadata
- `values.yaml`: Default configuration values
- `templates/`: Kubernetes manifest templates

## Usage
To install the chart:

```sh
helm install teamcity-helm-chart .
```

To uninstall:

```sh
helm uninstall teamcity-helm-chart
```
