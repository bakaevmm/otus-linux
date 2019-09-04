### Описание файлов:  
[process_analayzer.sh](process_analayzer.sh) --- скрипт анализирующий запущенные процессы. В выоде присутствует User Pid ParentPid State Cmdline(или name при отсутствии command).  
Описание функций доступно в теле скрипта отдельными комментариями.  
[nice_diff_process.sh](nice_diff_process.sh) --- скрипт запускающий в фоне два процесса dd с разными приоритетами и выполняющий измерение времени выполнения при помощи утилиты time.   
[Vagrantfile](Vagrantfile) --- файл описания VM для отладки и тестов. 
