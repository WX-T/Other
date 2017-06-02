> nmap 扫描端口及服务详情
    nmap -F -sT -v -sV 192.168.7.81 

 nmap 扫描漏洞
    nmap --script=vuln 123.59.58.79

 hrdya 爆破ssh
    hydra -L users.txt -P password.txt -t 1 -vV -e ns 192.168.1.104 ssh
