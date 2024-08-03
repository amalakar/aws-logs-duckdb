# aws-logs-duckdb

## About
AWS makes various log files available for their services (eg: ALB access log, cloudfront access log,
s3 access log etc). It is possible to use athena to query these files. But there is some 
overhead in setting up athena and there are cases where you may have these files locally, and 
you wanna analyze them quickly.

[duckdb](https://duckdb.org/) is a very popular analytical database that can be run locally over
csv, parquet, tsv etc among other file formats. This repo contains SQL statements that can be used 
to analyze aws log files using SQL locally.

## Supported Log files
 - [Amazon S3 server access log](https://docs.aws.amazon.com/AmazonS3/latest/userguide/LogFormat.html)
 - [Amazon ALB access log](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html)
 - [Amazon cloudfront access log](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html)
 - [Elastic Load Balancer classic](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/access-log-collection.html)


## How to use
1. Install [duckdb](https://duckdb.org/docs/installation/)
```bash
brew install duckdb
```

2. 

```
$ cd samples/s3_access_log/

$ duckdb
.read ../../sql/s3_access_log.sql

select uri_stem, bucket, http_method, http_status  from s3_access_log;
```
|            uri_stem             |       bucket        | http_method | http_status |
|---------------------------------|---------------------|-------------|------------:|
| /DOC-EXAMPLE-BUCKET1?versioning | DOC-EXAMPLE-BUCKET1 | GET         | 200         |
| /DOC-EXAMPLE-BUCKET1?logging    | DOC-EXAMPLE-BUCKET1 | GET         | 200         |
| /DOC-EXAMPLE-BUCKET1?policy     | DOC-EXAMPLE-BUCKET1 | GET         | 404         |
| /DOC-EXAMPLE-BUCKET1?versioning | DOC-EXAMPLE-BUCKET1 | GET         | 200         |
| /DOC-EXAMPLE-BUCKET1/s3-dg.pdf  | DOC-EXAMPLE-BUCKET1 | PUT         | 200         |

```sql
 select bucket, http_status, count(*) as cnt from s3_access_log group by 1,2;
```

|       bucket        | http_status | cnt |
|---------------------|------------:|----:|
| DOC-EXAMPLE-BUCKET1 | 200         | 4   |
| DOC-EXAMPLE-BUCKET1 | 404         | 1   |
