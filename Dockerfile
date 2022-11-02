FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
ADD conf.d /etc/nginx/conf.d
COPY ./nginxReloader.sh /etc/nginx/nginxReloader.sh
COPY ./entrypoint.sh /etc/nginx/entrypoint.sh

RUN chmod +x /etc/nginx/entrypoint.sh
RUN chmod +x /etc/nginx/nginxReloader.sh

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install inotify-tools -y 

ENTRYPOINT [ "/etc/nginx/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]