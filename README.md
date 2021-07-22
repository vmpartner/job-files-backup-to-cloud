# Backup files to cloud by cron schedule & rclone

Usage example
```bash
docker run -d \
  -e TZ="Europe/Moscow" \
  -e RCLONE_CONFIG_SELECTEL_TYPE="swift" \
  -e RCLONE_CONFIG_SELECTEL_ENV_AUTH="false" \
  -e RCLONE_CONFIG_SELECTEL_USER="my_user" \
  -e RCLONE_CONFIG_SELECTEL_KEY="my_password" \
  -e RCLONE_CONFIG_SELECTEL_AUTH="https://auth.selcdn.ru/v1.0" \
  -e RCLONE_CONFIG_SELECTEL_ENDPOINT_TYPE="private" \
  -e RCLONE_DEST="selectel:my_container/my_path" \
  -e CHECK_URL="https://hc-ping.com/my_check_token" \
  -v /my_file:/source:ro \
 vmpartner/job-files-backup-to-cloud
```

Used https://rclone.org for rsync to cloud
