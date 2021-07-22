#!/bin/sh

set -e

$DT=$(date '+%d%m%Y%H%M%S');
$SRC=backup_${DT}.tar

if [ ! -d /source ]; then
  return
else
  if [ "$RCLONE_DEST" = "**None**" ]; then
    echo "ERROR: Define $RCLONE_DEST"
    return
  echo "Start tar source"
  tar -cvf /${SRC} /source
  FILESIZE=$(stat -c%s /${SRC})
  echo "Size of ${SRC} = $FILESIZE bytes."
  rclone copy /${SRC} "$RCLONE_DEST"
  if [ "$CHECK_URL" = "**None**" ]; then
    echo "INFO: Define CHECK_URL with https://healthchecks.io to monitor sync job"
  else
    curl "$CHECK_URL"
  fi
fi