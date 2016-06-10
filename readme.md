# Sample PostgreSQL Docker with multicorn FDW
This is tiny sample for my medium post https://medium.com/@CzechJiri/making-tableau-awesome-r-713d9c6c5ee8#.k2h0n2dy5


## Setup Docker
install docker then simply run use this pre-build image

```
docker run --name postgres -d -i -p 5432:5432 czechjiri/tableau-postgres-multicorn
```

## Run Tableau
use PosgreSQL driver and point Tableau to

```
host: localhost
port: 5432
database: sample
username: test
password: test123
```


## sample SQL
here is sample SQL

```sql
   select rank() over(partition by (date_trunc('hour', "pubDate")) order by "pubDate" desc), 
          "pubDate", 
          title 
     from sample.reutersrss 
 order by 2 desc 
 limit 10
 ```
