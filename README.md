# Backup files to cloud

Usage example in k8s CronJob
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  labels:
    app: backup-grafana
  name: backup-grafana
  namespace: monitoring
spec:
  schedule: "0 0 */3 * *"
  successfulJobsHistoryLimit: 5
  failedJobsHistoryLimit: 5
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      template:
        spec:
          nodeSelector:
            node: tm-node-1
          containers:
            - name: backup-grafana
              image: vmpartner/job-files-backup-to-cloud:v1.1.0
              resources:
                limits:
                  cpu: 250m
                  memory: 256Mi
                requests:
                  cpu: 100m
                  memory: 64Mi
              env:
              - name: TZ
                value: "Europe/Moscow"
              - name: RCLONE_CONFIG_SELECTEL_TYPE
                value: "swift"
              - name: RCLONE_CONFIG_SELECTEL_ENV_AUTH
                value: "false"
              - name: RCLONE_CONFIG_SELECTEL_USER
                value: "my_user"
              - name: RCLONE_CONFIG_SELECTEL_KEY
                value: "my_password"
              - name: RCLONE_CONFIG_SELECTEL_AUTH
                value: "https://auth.selcdn.ru/v1.0"
              - name: RCLONE_CONFIG_SELECTEL_ENDPOINT_TYPE
                value: "public"
              - name: RCLONE_DEST
                value: "selectel:global/grafana"
              - name: CHECK_URL
                value: "https://hc-ping.com/d178069f-1e18-43db-b5c9-39c2d04f261c"
              volumeMounts:
                - mountPath: /etc/localtime
                  name: localtime
                  readOnly: true
                - mountPath: /source
                  name: grafana-storage
                  readOnly: true
          restartPolicy: OnFailure
          volumes:
            - hostPath:
                path: /etc/localtime
              name: localtime
            - name: grafana-storage
              hostPath:
                path: /mnt/k8s/monitoring/grafana
```

Used https://rclone.org for rsync to cloud
