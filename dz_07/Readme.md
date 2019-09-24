## Необходимо получить доступ к системе не зная пароля root и изменить его пароль
### Исходные данные и подводные камни:
Исходная конфигурация grub
```
    load_video
    set gfxpayload=keep
    insmod gzio
    insmod part_msdos
    insmod xfs
    set root='hd0,msdos2'
    if [ x$feature_platform_search_hint = xy ]; then
      search --no-floppy --fs-uuid --set=root --hint='hd0,msdos2'  570897ca-e759-4c81-90cf-389da6eee4cc
    else
      search --no-floppy --fs-uuid --set=root 570897ca-e759-4c81-90cf-389da6eee4cc
    fi
    linux16 /vmlinuz-3.10.0-862.2.3.el7.x86_64 root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop crashkernel=auto rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
    initrd16 /initramfs-3.10.0-862.2.3.el7.x86_64.img
```
При подобной конфигурации загрузчика не удалсь просто давить параметры ``` init=/bin/sh или rd.break``` . При старте был либо kernalpanic либо просто чёрный экран. Необходимо было принудительно перенаправить вывод на другую консоль.  Можно сделать параметром console=tty1.  
Так же не получилось обойти проверку selinux путём создания файла /.autorelabel. Пришлось отключить selinux в конфиг файле /etc/selinux/config.  

### Способ 1
1. При загрузке системы нажимаем e - переходим к редактированию параметров загрузки grub.  
2. В конце строки начинающийся с linux16 добавляем параметры ядра ``` init=/bin/sh console=tty1``` и нажимаем сtrl-x. Загрузчику будет передано указание запустить стандартный шелл /bin/sh в качестве первого процесса.  
3. Премонтируем корневую fs в rw режим ``` mount -o remount rw /```  
4. Отключаем selinux в конфиг файле /etc/selinux/config.  
5. Меняем пароль root и перезагружаемся.  

### Способ 2
1. При загрузке системы нажимаем e - переходим к редактированию параметров загрузки grub.  
2. В конце строки начинающейся с linux16 добавляем ``` rd.break console=tty1``` и нажимаем сtrl-x. Загрузка системы будет остановлена в момент Initramfs и запустится его шелл с ограниченным набором команд. Корень fs будет находиться в /sysroot.  
3. Премонтируем fs в rw режим ``` mount -o remount rw /sysroot```  
4. Выполним chroot в /sysroot  
5. Отключаем selinux в конфиг файле /etc/selinux/config.  
6. Меняем пароль root и перезагружаемся.  
