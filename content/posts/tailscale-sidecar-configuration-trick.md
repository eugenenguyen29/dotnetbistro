---
title: "A Tailscale Sidecar Configuration Trick"
date: 2025-01-13
tags:
  - Tailscale
  - Docker
---

Alex from the Tailscale YouTube channel just uploaded a new video about CopyParty, but the greatest thing was the inline configs block trick for Docker Compose.

Here's an example Docker Compose for my self-hosted SearXNG instance on my homelab.
```yml compose.yml
configs:
  searxng-ts-serve:
    content: |
      {"TCP":{"443":{"HTTPS":true}},
      "Web":{"$${TS_CERT_DOMAIN}:443":
          {"Handlers":{"/":
          {"Proxy":"http://127.0.0.1:8080"}}}},
      "AllowFunnel":{"$${TS_CERT_DOMAIN}:443":false}}

networks:
  searxng:

volumes:
  valkey-data2:
  searxng-data:

services:
  searxng-ts:
    image: tailscale/tailscale:latest
    container_name: searxng-ts
    hostname: searxng
    environment:
      - TS_AUTHKEY=${TS_AUTHKEY}
      - TS_STATE_DIR=/var/lib/tailscale
      - TS_SERVE_CONFIG=/config/serve.json
      - TS_USERSPACE=true
    configs:
      - source: searxng-ts-serve
        target: /config/serve.json
    cap_add:
      - net_admin
      - sys_module
    volumes:
      - ${PWD}/tailscale/ts-state:/var/lib/tailscale
    restart: always

  searxng-app:
    container_name: searxng-app
    image: docker.io/searxng/searxng:latest
    network_mode: service:searxng-ts
    depends_on:
      - searxng-ts
      - redis
    restart: unless-stopped
    ...

  redis:
    ...
```

Sweet! I don't have to make a separate file for this small, repetitive configuration.
But one downside is the lack of linting and formatting to check for errors during development.
