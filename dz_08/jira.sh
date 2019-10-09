#!/bin/sh

###################################
#Устанавливаем необходимые пакеты

yum install wget fontconfig -y

###################################
#Скачиваем дистрибутив jira и устанавливаем с сиспользованием файла ответов
cd /tmp/ && wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-core-8.4.2-x64.bin  && chmod a+x atlassian-jira-core-8.4.2-x64.bin 
./atlassian-jira-core-8.4.2-x64.bin -q -varfile /vagrant/jira_file/response.varfile 

###################################
#Копируем unit 

cp /vagrant/jira_file/jira.service /etc/systemd/system/

###################################
#Стартуем jira с использованием systemctl

sudo systemctl enable jira
sudo systemctl start jira



