#!/bin/bash

###################################
#Объявляем первоначальные переменные
LOGFILE=./access.log
CACHEDIR=cache
CACHE_FILE_ALL=cache/cache_file_all
CACHE_FILE_LAST=cache/cache_file_last
LOCKFILE=cache/lockfile

###################################
#Создаём необходимые файлы и директории при первом запуске
if [ ! -d $CACHEDIR ];
then mkdir cache 
echo 1 > $CACHEDIR/NSL
fi

###################################
#Делаем lockfile для защиты от мульти запуска
if [ -f $LOCKFILE ]
then echo "Скрипт уже запущен, дождитесь завершения его работы. PID = `cat $LOCKFILE`" 
exit 0
fi

###################################
#Создаём trap для решения проблем с внезапным прерыванием
(set -o noclobber; echo "$$" > "$LOCKFILE") 2> /dev/null
trap 'rm -f "$LOCKFILE"; exit $?' INT TERM EXIT

###################################
#Формируем кеш файлы для последующей рассылки
#Данный файл обрабатывает весь лог целиком
echo -e "Время первой обработанной записи" > $CACHE_FILE_ALL
head -1 $LOGFILE | awk '{print $4}' | sed s/\\\[//g >> $CACHE_FILE_ALL
echo -e "Время последней обработанной записи" >> $CACHE_FILE_ALL
tail -1 $LOGFILE | awk '{print $4}' | sed s/\\\[//g >> $CACHE_FILE_ALL
echo -e "\nДанная статистика собирается по всему файлу.\n------------------------------- \nТОП ip адресов по запросам: \n" >> $CACHE_FILE_ALL
cat $LOGFILE| awk '{print $1}' | sort | uniq -c | sort -rg |  head -5 | awk '{ print " IP "  $2 " число запросов --- " $1}' >> $CACHE_FILE_ALL
echo -e "\nОшибки сервера: \n " >> $CACHE_FILE_ALL
cat $LOGFILE| awk '{print $9}' | sort | uniq -c | egrep "40.|50." | sort -rg | awk '{ print " Error code "  $2 " встречается в логе " $1 " раз"}' >> $CACHE_FILE_ALL
echo -e "\nОбщая статистика кодов ответов: \n " >> $CACHE_FILE_ALL
cat $LOGFILE| awk '{print $9}' | grep -v "-"  | sort | uniq -c | sort -rg | awk '{ print " Code "  $2 " встречается в логе " $1 " раз"}' >> $CACHE_FILE_ALL
echo -e "\n--------------- \n \nОбработано строк:" >> $CACHE_FILE_ALL
cat $LOGFILE| wc -l | awk '{print $1}' >> $CACHE_FILE_ALL

#Данный файл обрабатывает часть лога основываясь на номере строки записанном при предыдущей обработке скрипта(NSL)
echo -e "\n \n \nВремя первой обработанной записи" > $CACHE_FILE_LAST
sed -n `cat ./cache/NSL`p $LOGFILE | awk '{print $4}' | sed s/\\\[//g >> $CACHE_FILE_LAST 
echo -e "Время последней обработанной записи" >> $CACHE_FILE_LAST
tail -1 $LOGFILE | awk '{print $4}' | sed s/\\\[//g >> $CACHE_FILE_LAST
echo -e "Данная статистика собирается за последний прогон скрипта.\n------------------------------- \nТОП ip адресов по запросам: \n" >> $CACHE_FILE_LAST
tail -n +`cat ./cache/NSL` $LOGFILE| awk '{print $1}' | sort | uniq -c | sort -rg |  head -5 | awk '{ print " IP "  $2 " число запросов --- " $1}' >> $CACHE_FILE_LAST
echo -e "\nОшибки сервера: \n " >> $CACHE_FILE_LAST
tail -n +`cat ./cache/NSL` $LOGFILE| awk '{print $9}' | sort | uniq -c | egrep "40.|50." | sort -rg | awk '{ print " Error code "  $2 " встречается в логе " $1 " раз"}' >> $CACHE_FILE_LAST
echo -e "\nОбщая статистика кодов ответов: \n " >> $CACHE_FILE_LAST
tail -n +`cat ./cache/NSL` $LOGFILE| awk '{print $9}' | grep -v "-"  | sort | uniq -c | sort -rg | awk '{ print " Code "  $2 " встречается в логе " $1 " раз"}' >> $CACHE_FILE_LAST
echo -e "\n--------------- \n \nОбработано строк:" >> $CACHE_FILE_LAST
tail -n +`cat ./cache/NSL` $LOGFILE| wc -l | awk '{print $1}' >> $CACHE_FILE_LAST

###################################
#Отправляем результаты работы скрипта на почту
echo "`cat $CACHE_FILE_ALL $CACHE_FILE_LAST`" | mail -s "Отчёт по сканированию лога" vagrant

###################################
#Запоминаем последную обработанную строку
LL=`wc -l $LOGFILE | awk '{print $1}'` ### last line serch
NSL=$(($LL + 1)) ### next line search 
echo $NSL > cache/NSL

###################################
#Удаляем cache и lock файлы
rm $LOCKFILE $CACHE_FILE_ALL $CACHE_FILE_LAST