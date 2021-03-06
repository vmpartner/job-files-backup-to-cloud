#!/bin/sh

set -e

if [ ! -d /source ]; then
  echo "Bad source"
  return
else
  if [ "$RCLONE_DEST" = "**None**" ]; then
    echo "ERROR: Define $RCLONE_DEST"
    return
  fi
  echo "Start $(date '+%d-%m-%Y %H:%M:%S')"
  FILESIZE=$(stat -c%s /${SRC})
  echo "Size of ${SRC} = $FILESIZE bytes."
  echo "rclone copy /source $RCLONE_DEST $RCLONE_PARAMS"
  rclone copy /source $RCLONE_DEST $RCLONE_PARAMS
  if [ "${CHECK_URL}" = "**None**" ]; then
    echo "INFO: Define CHECK_URL with https://healthchecks.io to monitor sync job"
  else
    echo "Curl check url: ${CHECK_URL}"
    curl "${CHECK_URL}"
  fi
  echo "Finish $(date '+%d-%m-%Y %H:%M:%S')"
fi