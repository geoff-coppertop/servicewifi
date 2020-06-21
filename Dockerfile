
FROM coppertopgeoff/servicebase:edge

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
        dnsmasq         \
        wireless-tools  \
        curl            \
	&& rm -rf /var/lib/apt/lists/*

RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*armv7hf\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/app/src/

COPY --chown=service:service ./src/start.sh /usr/app/src/start.sh