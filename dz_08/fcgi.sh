#!/bin/sh

###################################
#Устанавливаем необходимые пакеты

yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y

###################################
#Раскомментируем строки в конфиг файле spawn-fcgi

sed -i '/SOCKET=/s/^#//g' /etc/sysconfig/spawn-fcgi
sed -i '/OPTIONS=/s/^#//g' /etc/sysconfig/spawn-fcgi

###################################
#Копируем подготовленный заранее unit файл

SRC=/vagrant/fcgi_file
mv $SRC/spawn-fcgi.service /etc/systemd/system/

###################################
#Запускаем сервис

sudo systemctl enable spawn-fcgi
sudo systemctl start spawn-fcgi