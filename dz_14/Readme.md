### Описание ДЗ:
С помощью Vagrant создан стенд с инсталяцией borg в качестве системы РК.  
Для теста настроил cron job, который каждые две минуты выполняет задание резервного копирования папки etc с клиента на сервер.  

Пример работы задания:  
```
[root@borgserver vagrant]# borg list /home/borg/backup_etc/
etc-Mon Nov 18 08:56:02 UTC 2019     Mon, 2019-11-18 08:56:04 [60d21e785d0e3340b5b2a3e78fee87ee60de1681ab1ed9f2a7191aa480b80139]
etc-Mon Nov 18 08:58:01 UTC 2019     Mon, 2019-11-18 08:58:04 [56fc68ff3621d56b3d78c6acdb76305cff9d3d1ec7bf20703d984338ba82b117]
etc-Mon Nov 18 09:00:01 UTC 2019     Mon, 2019-11-18 09:00:03 [0ae2d14b9da441cd34ab7460e687e7921e455502bb852eeb8365803df8789630]
etc-Mon Nov 18 09:02:01 UTC 2019     Mon, 2019-11-18 09:02:03 [562c8f51d040bbe106abdf87487534dbafca223d893d1e89452d52561e78edf1]
```

### Описание запуска для проверки ДЗ:  
В vagrant добавлен ansible provision с вызовом роли для выполнения playbook на хосте.  
Скачайте репозиторий и запустите виртуальный стенд с помощью Vagrant file.  

Настройка сервера описана в файле [mian.yaml](roles/borgserver/tasks/main.yml)  
Настройка клиента описана в файле [mian.yaml](roles/borgclient/tasks/main.yml)  
