### Описание файлов: 
[rpm.sh](rpm.sh) --- скрипт выполняющий ДЗ.
Описание функций доступно в теле скрипта отдельными комментариями.  
[nginx.spec](nginx.spec) --- файл spec для сборки nginx c openssl.  
[default.conf](default.conf) --- файл конфигурации nginx.  
[otus.repo](otus.repo) --- файл содержащий описание репозитория для yum.  
[Vagrantfile](Vagrantfile) --- файл VM с запущеным nginx и репозиторием.  

### Описание запуска для проверки ДЗ:  
Запсутите ВМ с помощью vagrant файла.  

### Дистрибьюция с помощью docker.
Собрал докер имейдж с nginx собранном с openssl.  
В контейнере установлен nginx. Cоздан репозеторий? куда добавлен один пакет и с помощью nginx пакет вывешен в web. 

В репозитории есть [Dockerfile](docker/Dockerfile) на основании которого делается сборка.
Ссылка на Dockerhub --- https://hub.docker.com/r/bakaevmm/rpm-nginx
