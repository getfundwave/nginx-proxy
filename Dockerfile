FROM --platform=linux/amd64 nginx:stable-alpine

RUN rm /etc/nginx/conf.d/default.conf
ADD conf.d /etc/nginx/conf.d
COPY ./nginxReloader.sh /etc/nginx/nginxReloader.sh
COPY ./entrypoint.sh /etc/nginx/entrypoint.sh

RUN chmod +x /etc/nginx/entrypoint.sh
RUN chmod +x /etc/nginx/nginxReloader.sh

RUN apk update && apk add bash
RUN apk add inotify-tools

ENTRYPOINT [ "/bin/bash", "/etc/nginx/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]