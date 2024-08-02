# aws-logs-duckdb

Install duckdb
https://duckdb.org/docs/installation/

```
$ ls logs/
E3CAFWEWER.2024-08-01-23.00058224.gz

$ cd logs/

$ duckdb
.read 'cloudfront_access_log.sql'

D select sc_status, count(*) as cnt from access_logs group by 1 order by 1 desc;
┌───────────┬────────┐
│ sc_status │  cnt   │
│   int32   │ int64  │
├───────────┼────────┤
│       502 │    601 │
│       429 │     12 │
│       422 │      7 │
│       408 │      5 │
│       404 │     40 │
│       403 │     75 │
│       401 │    146 │
│       400 │    150 │
│       304 │    439 │
│       302 │      1 │
│       204 │      1 │
│       202 │    108 │
│       201 │     41 │
│       200 │ 102600 │
│         0 │    687 │
├───────────┴────────┤
│ 15 rows  2 columns │
└────────────────────┘
```
