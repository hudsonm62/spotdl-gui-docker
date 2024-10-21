FROM python:3.12-alpine3.20 AS dl

RUN apk add --no-cache git && \
  git clone --single-branch https://github.com/spotDL/spotify-downloader.git

FROM python:3.12-alpine3.20 AS run
ENV PYTHONOPTIMIZE=1

# Install system dependencies
RUN apk update && apk upgrade --no-cache && \
  apk add --no-cache ffmpeg openssl ca-certificates && \
  pip install --upgrade --no-cache-dir poetry wheel spotipy && \
  apk del --purge py3-pip py-pip && \
  rm -rf /var/lib/apt/lists/* && \
  # PURGE APK
  rm -f /sbin/apk && \
  rm -rf /etc/apk && \
  rm -rf /lib/apk && \
  rm -rf /usr/share/apk && \
  rm -rf /var/lib/apk

# install spotdl deps
COPY --from=dl /spotify-downloader/poetry.lock /spotify-downloader/pyproject.toml /
RUN poetry install --no-cache --without dev --sync
COPY --from=dl /spotify-downloader/ ./
RUN poetry install --no-cache --without dev --sync

# music dir for output
WORKDIR /music
VOLUME /music

EXPOSE 8080
ENTRYPOINT ["poetry", "run", "spotdl", "web", "--host", "0.0.0.0", "--port", "8080"]
