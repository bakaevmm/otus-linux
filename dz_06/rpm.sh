#!/bin/bash

###################################
# Выключаем selinux
setenforce 0

###################################
# Устанавливаем необходимые для сборки пакеты
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils yum install gcc

###################################
# Скачиваем необходимые для сборки исходники
cd /root/ && wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
wget https://www.openssl.org/source/latest.tar.gz && tar -xf latest.tar.gz

###################################
# Создаём необходимые для сборки директории и распаковываем исходники
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
mv /vagrant/nginx.spec /root/rpmbuild/SPECS/nginx.spec

###################################
# Устанавливаем все зависимости
yum-builddep -y rpmbuild/SPECS/nginx.spec

###################################
# Делаем сборку на основании spec файла
rpmbuild -bb rpmbuild/SPECS/nginx.spec

###################################
# Устанавливаем и запускаем собраный nginx 
yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm && mv /vagrant/default.conf /etc/nginx/conf.d/
systemctl start nginx && systemctl enable nginx

###################################
# С помощью nginx вешаем rpm на web
mkdir /usr/share/nginx/html/repo && cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/

###################################
# Создаём репозиторий
createrepo /usr/share/nginx/html/repo/

###################################
# Вобавляем репозиторий в yum
mv /vagrant/otus.repo  /etc/yum.repos.d/






