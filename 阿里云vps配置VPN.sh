
阿里云服务器配置详解（测试成功） 
我的操作环境：阿里云香港节点云服务器，操作系统：CentOS 6.3 64位 
名词解释：pptp是VPN服务器类型之一，PPP是一种数据链路层协议，iptables是IP信息包过滤系统。 
 
【正文】 
1 服务器端安装软件 
1.1 首先安装ppp，命令： 
[root@kuro ~]#yum install -y ppp iptables 
提示Complete! ，安装成功； 
1.2安装pptp，由于pptp没有存放在CentOS的源中，所以用yum命令安装返回的是找不到安装包的，需要从网上下载，安装命令如下： 
[root@kuro ~]#rpm -ivh http://xinzhi.so/pptpd-1.3.4-2.el6.x86_64.rpm
  最新版pptp下载地址： 
    （http://rpm.pbone.net/index.php3/stat/4/idpl/26021844/dir/redhat_el_6/com/pptpd-1.4.0-3.el6.x86_64.rpm.html ）
 
 
2 配置pptp 
2.1编辑/etc/pptpd.conf，命令如下 
[root@kuro ~]#vi /etc/pptpd.conf 
将 
#localip 192.168.0.1 
#remoteip 192.168.0.234-238,192.168.0.245 
修改成 
localip 192.168.0.1 
remoteip 192.168.0.234-238,192.168.0.245 
即将这两行第一个字符“#”去掉，保存退出 
（Vi 命令补充：如需查找abc则输入”:/abc”，修改文本输入i，退出修改按esc，保存并退出输入”:/wq”） 
2.2编辑/etc/ppp/options.pptpd，命令如下 
[root@kuro ~]#vi /etc/ppp/options.pptpd 
将 
#ms-dns 10.0.0.1 
#ms-dns 10.0.0.2 
改成 
ms-dns 8.8.8.8 
ms-dns 8.8.4.4 
即将这两行第一个字符“#”去掉，而后修改DNS的IP。 
2.3设置使用pptp的用户名和密码 
命令： 
[root@kuro ~]#vi /etc/ppp/chap-secrets 
打开后只有两行，而且一个账号都没有 
# Secrets for authentication using CHAP 
# client server secret IP addresses 
根据您的需要添加账号，每行一个。按照：“用户名 pptpd 密码 ip地址”的格式输入，每一项之间用空格分开，例如：kuro pptpd 123456 * （*表示所有IP） 
保存并退出。 
 
3、修改内核设置，使其支持转发 
命令： 
[root@kuro ~]#vi /etc/sysctl.conf 
将net.ipv4.ip_forward=0 
改成net.ipv4.ip_forward=1 
将net.ipv4.tcp_syncookies= 1 
改成 #net.ipv4.tcp_syncookies= 1 
保存并退出 
 
执行以下命令使修改后的内核生效 
[root@kuro ~]#sysctl -p 
 
4、添加iptables转发规则 
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth1 -jMASQUERADE 
（注意：由于阿里云是双网卡，内网eth0，外网eth1，所以这块特别容易误写为eth0，这也是为什么很多杂乱的教程无法配置成功的原因之一） 
 
添加好转发规则后保存一下并重启iptables 
[root@kuro ~]#/etc/init.d/iptables save  
[root@kuro ~]#/etc/init.d/iptables restart 
 
 
5、重启pptp服务 
[root@kuro ~]#/etc/init.d/pptpd restart 
这里要注意一下，其实此时pptp还没运行起来。所以使用restart重启，会显示Shutting down pptp [FAILED]。还会有一个警告，可以忽略。如不放心可以再用以上命令重启一下pptp就非常顺利的运行了。 
 
6、设置pptp和iptables随系统启动 
[root@kuro ~]#chkconfig pptpd on  
[root@kuro ~]#chkconfig iptables on 
至此，pptp服务端安装结束。 
在PC端的“网络和共享中心”，设置新的连接或网络，即可访问VPN。 
#last查看vpn在线用户
last | grep still | grep ppp
#2. 查看在线用户别名
#如果你觉得繁琐，你可以将它写到环境变量中.
cat /etc/profile | grep vpn

alias ttlsavpn='last | grep still | grep ppp'
#使用ttlsavpn命令
ttlsavpn
