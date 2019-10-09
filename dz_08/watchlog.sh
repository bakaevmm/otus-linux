#!/bin/sh

###################################
#Отключаем Selinux

echo 0 > /etc/selinux/enforce
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

###################################
#Копируем заранее подготовленные файлы

SRC=/vagrant/wachlog_file
chmod a+x $SRC/watchlog.sh 
mv $SRC/watchlog /etc/sysconfig/
mv $SRC/watchlog.log  /var/log/
mv $SRC/watchlog.sh /opt/
mv $SRC/watchlog.service /etc/systemd/system/
mv $SRC/watchlog.timer /etc/systemd/system/

###################################
#Запускаем таймер и сервис

sudo systemctl enable watchlog.timer
sudo systemctl start watchlog.timer
sudo systemctl enable watchlog.service
sudo systemctl start watchlog.service