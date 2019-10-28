### Описание ДЗ: 
Создали скрипт который проверяет наличие пользователя в группе admin и запрещает логин пользователя без жтой группы в выходные дни. Для вызова скрипта используем модуль - pam_exec.so  
Пример работы модуля:  
```
ssh admin@localhost -p 2222
admin@localhost's password:
Last login: Mon Oct 28 12:06:22 2019
```  
```
ssh noadmin@localhost -p 2222
noadmin@localhost's password:
/bin/pam_script.sh failed: exit code 1
Connection closed by 127.0.0.1 port 2222
```

Пользователю admin добавлены права на выполнение sudo без пароля. Реализованно с помощью файла [admin](roles/pam/files/adm_user) добавленного в /etc/sudoers.d/  

### Описание запуска для проверки ДЗ:
В vagrant добавлен ansible provision с вызовом роли для выполнения playbook на хосте.  
Скачайте репозиторий и запустите виртуальную машину с помощью Vagrant file.  
Описание шагов можно увидить в файле [mian.yaml](roles/pam/tasks/main.yml)
