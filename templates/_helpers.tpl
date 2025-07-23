{{- define "teamcity.postgres.host" -}}
postgres.{{ .Values.namespace.server }}.svc.cluster.local
{{- end -}}