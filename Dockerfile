FROM debian:stable-slim

LABEL version="1.0" \
      maintainer="william@hyp5r.io"

COPY docker-run.sh /

RUN \
  chmod +x /docker-run.sh && \
  apt-get update && \
  apt-get -y install --no-install-recommends \
    wget && \
  mkdir /usr/local/ezproxy && \
  mkdir /usr/local/ezproxy/config && \
  wget --no-check-certificate -O /usr/local/ezproxy/ezproxy https://help.oclc.org/@api/deki/files/9850/ezproxy-linux.bin && \
  chmod +x /usr/local/ezproxy/ezproxy && \
  apt-get purge -y \
    wget && \
  apt-get clean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

ENV EZPROXY_WSKEY=

VOLUME /usr/local/ezproxy/config
EXPOSE 2048

CMD ["/docker-run.sh"]