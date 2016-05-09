# Sample multicorn postres docker
This is tiny sample for my medium post https://medium.com/@CzechJiri/making-tableau-awesome-r-713d9c6c5ee8#.k2h0n2dy5


## Setup Docker
clone this repo, install docker then simply run this from command line

```
docker build -t multicorn .
docker run --name multicorn -d -i -p 5432:5432 multicorn
```

## Run Tableau
then point tableau to

```
host: localhost
port: 5432
database: sample
username: test
password: test123
```


## sample SQL
here is sample SQL
```
   select rank() over(partition by (date_trunc('hour', "pubDate")) order by "pubDate" desc), 
          "pubDate", 
          title 
     from sample.reutersrss 
 order by 2 desc 
 limit 10
 ```
