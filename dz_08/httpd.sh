#!/bin/sh

###################################
#Копируем заранее подготовленные файлы 

SRC=/vagrant/httpd_file
cp $SRC/httpd@.service /etc/systemd/system/
cp $SRC/httpd-first /etc/sysconfig/
cp $SRC/httpd-second /etc/sysconfig/
cp $SRC/first.conf /etc/httpd/conf/
cp $SRC/second.conf /etc/httpd/conf/

###################################
#Запускаем два сервиса на разных портах с использованием разных конфиг файлов

sudo systemctl daemon-reload
sudo systemctl start httpd@first
sudo systemctl start httpd@second
