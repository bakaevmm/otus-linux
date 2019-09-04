#!/bin/bash

###################################
# Объявляем переменную, со списком всех процессов
PROCLIST=`find /proc/ -maxdepth 1 -type d  -name "*[0-9]*"`

###################################
# Подготавливаем первую строку для отображения
echo -e "USERS \tPID \tPARENT_PID \tSTAT \tCOMMAND"

###################################
# Запускаем цикл, для сбора статистики по каждому процессу
for process in $PROCLIST
do

# Ищем uid пользователя процесса и проставляем делаем его сопоставление с username
uid=$(cat $process/status 2>/dev/null | egrep "^Uid" | awk '{print $2}')
if [ "$uid" == "" ];
then
 continue
fi
user=$(cat /etc/passwd 2>/dev/null | awk -v uid=$uid -F: '{if($3==uid){print $1}}')

# Забираем pid, ppid, stat процесса
pid=$(cat $process/status 2>/dev/null | egrep "^Pid:" | awk '{print $2}')
ppid=$(cat $process/status 2>/dev/null | egrep "^PPid:" | awk '{print $2}')
state=$(cat $process/status 2>/dev/null | egrep "^State:" | awk '{print $2}')

# Если заполнена cmdline то выводим её, если нет, то выводим name
if [ "$(cat $process/cmdline 2>/dev/null)" == "" ];
then
  cmdline=$(cat $process/status 2>/dev/null | egrep "^Name:" | awk '{print $2}')
else
  cmdline=$(cat $process/cmdline 2>/dev/null)
fi

# Выводим информацию по каждому процессу
echo -e "$user \t$pid \t$ppid \t$state \t$cmdline "
done
