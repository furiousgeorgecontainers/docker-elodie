FROM alpine:3.10

ARG BUILD_DATE
ARG VERSION
LABEL build_date="${BUILD_DATE}"
LABEL version="${VERSION}"

RUN \
 echo "**** Install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies --upgrade \
    build-base \
    git \
    jpeg-dev \
    musl-dev \
    python-dev \
    zlib-dev && \
 echo "**** Install runtime packages ****" && \
 apk add --no-cache --upgrade \
    bash \
    exiftool \
    perl-image-exiftool \
    python \
    python-dev \
    py-pip \
    su-exec && \
 echo "**** Install Elodie ***" && \
 git clone https://github.com/jmathai/elodie.git /app && \
    pip install -r /app/requirements.txt && \
    ln -s /app/elodie.py /usr/bin/elodie && \
 echo "**** cleanup ****" && \
 apk del --purge \
    build-dependencies && \
 rm -rf \
    /root/.cache \
    /tmp/*

ENV ELODIE_APPLICATION_DIRECTORY="/config"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "--help" ]
