#!/bin/bash

NLP="+20"
NHP="-20"

echo "Время выполнения команды с высоким приоритетом  $(time (nice -n $NHP dd if=/dev/urandom of=/dev/null count=1000 bs=1M >/dev/null 2>&1)) " &
echo "Время выполнения команды с низким приоритетом  $(time (nice -n $NLP dd if=/dev/urandom of=/dev/null count=1000 bs=1M >/dev/null 2>&1)) " &