FROM nginx:stable-alpine

WORKDIR /etc/nginx

COPY ./dhparams.pem certs/dhparams.pem
RUN rm conf.d/default.conf 

COPY ./conf.d conf.d
COPY ./nginxReloader.sh nginxReloader.sh
COPY ./entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh
RUN chmod +x nginxReloader.sh

RUN apk update && apk add bash
RUN apk add inotify-tools

ENTRYPOINT [ "/bin/bash", "/etc/nginx/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]