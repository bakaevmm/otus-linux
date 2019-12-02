FROM alpine:3.10.3
RUN apk update && apk upgrade && apk add nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.php /var/www/index.php
RUN mkdir /run/nginx && chown nginx:nginx /run/nginx
CMD ["nginx", "-g", "daemon off;"]