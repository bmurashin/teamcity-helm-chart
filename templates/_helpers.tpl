{{- /*
teamcity.postgresql.host Will get the bitnami chart postgresql service name if embedded postgres is chosen (postgresql.deploy is true)
otherwise it will be the host from values.yaml - which is meant to the external database host
*/}}
{{- define "teamcity.postgresql.host" -}}
{{- if .Values.postgresql.deploy -}}
{{ include "postgresql.v1.primary.fullname" .Subcharts.postgresql }}.{{ .Values.namespace.server }}.svc.cluster.local
{{- else -}}
{{ .Values.postgresql.host }}
{{- end -}}
{{- end -}}

{{- /*
teamcity.db.url Will generate the JDBC URL for the database connection
Currently only supports Postgresql
*/}}
{{- define "teamcity.db.url" -}}
{{- if .Values.database.type | eq "postgresql" -}}
jdbc:{{ .Values.database.type }}://{{ include "teamcity.postgresql.host" . }}:{{ .Values.postgresql.service.ports.postgresql }}/{{ .Values.postgresql.auth.database }}
{{- end -}}
{{- end -}}


{{- /*
Map server-** configmaps set into volumes manifest for TC server statefulset
see templates/server/configmap-server.yaml template
*/}}
{{- define "teamcity.server.configs.volumes" -}}
{{- $processedDict := dict -}}
{{- range $path, $bytes := .Files.Glob (printf "resources/%s/server/**" .Values.server.dump.version ) -}}
{{- $name := (dir $path) -}}
{{- if not (hasKey $processedDict $name) -}}
{{- $_ := set $processedDict $name "true" }}
- name: server-{{ $name | sha1sum }}
  configMap:
    name: server-{{ $name | sha1sum -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /*
Map server-** configmaps set into volume mounts manifest for TC server statefulset
see templates/server/configmap-server.yaml template
*/}}
{{- define "teamcity.server.configs.volumeMounts" -}}
{{- $processedDict := dict }}
{{- range $path, $bytes := .Files.Glob (printf "resources/%s/server/**" .Values.server.dump.version ) }}
{{- $name := (dir $path) }}
{{- if not (hasKey $processedDict $name) }}
{{- $_ := set $processedDict $name "true" }}
- mountPath: /server-config.dist/{{ $name | trimPrefix (printf "resources/%s/server/" $.Values.server.dump.version ) }}
  name: server-{{ $name | sha1sum }}
{{- end }}
{{- end }}
{{- end -}}


{{/*
Expand the name of the chart.
*/}}
{{- define "teamcity.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 53 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 53 chars because some Kubernetes name fields are limited by 63 chars (by the DNS naming spec),
leaving spare 10 chars to add components' names like '-agent', '-haproxy', etc
If release name contains chart name it will be used as a full name.
*/}}
{{- define "teamcity.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 53 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 53 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 53 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "teamcity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "teamcity.labels" -}}
helm.sh/chart: {{ include "teamcity.chart" . }}
{{ include "teamcity.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "teamcity.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamcity.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to be used by TC server to control build agents' pods
*/}}
{{- define "teamcity.server.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create }}
{{- default (include "teamcity.fullname" .) .Values.server.serviceAccount.name }}
{{- else }}
{{- default "teamcity" .Values.server.serviceAccount.name }}
{{- end }}
{{- end }}
