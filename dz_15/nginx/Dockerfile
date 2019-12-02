FROM alpine:3.10.3
RUN apk update && apk upgrade && apk add nginx
COPY files/default.conf /etc/nginx/conf.d/default.conf
COPY html/index.html /var/lib/nginx/html/index.html
RUN mkdir /run/nginx && chown nginx:nginx /run/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]