CREATE OR REPLACE TABLE classic_access_log AS WITH log AS (
        SELECT *
        FROM read_csv(
                -- path to files, currently it loads all files in local dir, you may want to change this
                '*',
                delim = ' ',
                nullstr = '-',
                header = FALSE,
                auto_detect = FALSE,
                -- conn_trace_id is missing for certain logs at times
                null_padding = TRUE,
                COLUMNS = {
                    'time': 'timestamp',
                    'elb': 'VARCHAR',
                    'client': 'VARCHAR',
                    'backend': 'VARCHAR',
                    'request_processing_time': 'double',
                    'backend_processing_time': 'double',
                    'response_processing_time': 'double',
                    'elb_status_code': 'int',
                    'backend_status_code': 'VARCHAR',
                    'received_bytes': 'bigint',
                    'sent_bytes': 'bigint',
                    'request': 'VARCHAR',
                    'user_agent': 'VARCHAR',
                    'ssl_cipher': 'VARCHAR',
                    'ssl_protocol': 'VARCHAR'
                }
        )
)
SELECT * EXCLUDE(request),
        split_part(request, ' ', 1) AS http_method,
       split_part(request, ' ', 2) AS request_uri,
       split_part(request, ' ', 3) AS http_protocol
FROM log;