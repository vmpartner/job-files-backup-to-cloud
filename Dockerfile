FROM alpine

ENV RCLONE_DEST **None**
ENV SCHEDULE **None**
ENV CHECK_URL **None**
ENV RCLONE_PARAMS ""

RUN apk update && apk add curl
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

ADD upload.sh /upload.sh
RUN chmod +x /upload.sh

USER root

CMD ["sh", "upload.sh"]
