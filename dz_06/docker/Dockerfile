FROM centos

COPY nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /tmp/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

RUN yum localinstall -y /tmp/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm && mkdir /usr/share/nginx/html/repo/ && mv /tmp/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
RUN yum install -y createrepo  && createrepo /usr/share/nginx/html/repo/
COPY default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
