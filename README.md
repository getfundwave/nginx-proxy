# getfundwave/nginx-proxy
Simple Ngnix proxy for docker that routes traffic to upstream based on path

Unlike https://github.com/nginx-proxy/nginx-proxy :
(a) this repo doesn't require docker.sock. Instead the ghcr.io/getfundwave/nginx-proxy server listens to changes in certs using inotifywait.
(b) this repo is meant for path based forwarding (/service1), instead of domain based forwarding (service1.yourdomain.com)

Sample docker-compose:

```
  nginx:
    container_name: nginx
    image: ghcr.io/getfundwave/nginx-proxy:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - certs:/etc/nginx/certs:ro
      - nginxconf:/etc/nginx/conf.d
      - nginxhtml:/usr/share/nginx/html:rw
      - ./proxy.locations:/etc/nginx/conf.d/proxy.locations
      - ./upstream.conf:/etc/nginx/conf.d/upstream.conf
     #- ./client_max_body_size.conf:/etc/nginx/conf.d/client_max_body_size.conf:ro
    environment:
      - DISABLE_ACCESS_LOGS=true
    restart: always

  acme:
    container_name: acme
    image: ghcr.io/getfundwave/nginx-acme:alpine
    depends_on:
      - "nginx"
    volumes:
      - certs:/etc/nginx/certs:rw
      - nginxconf:/etc/nginx/conf.d
      - nginxhtml:/usr/share/nginx/html:rw
    environment:
      - VIRTUAL_HOST=${HOST}
      - ACME_EMAIL=admin@<your-domain>
    restart: always

```
