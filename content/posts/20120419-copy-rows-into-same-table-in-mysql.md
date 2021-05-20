---
title: Copy row(s) into same table in MySQL
date: 2012-04-19T03:20:16+00:00
---
I have a trouble when I want to copy row from another row in same table with MySQL, after a little googling, I found the solution is very simple, we just have to add 2 command like below.

```sql
> SELECT rowName FROM tableName FOR UPDATE;  
> UPDATE tableName SET rowName2 = rowName;
```

It is easy right? I post as a little article like this just to want help another people with same problem. So, hope this post will help you, enjoy!