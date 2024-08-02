CREATE OR REPLACE TABLE s3_access_log AS WITH log AS (
        SELECT *
        FROM read_csv(
                -- path to files, currently it loads all files in local dir, you may want to change this
                '*',
                delim = ' ',
                nullstr = '-',
                header = false,
                auto_detect = false,
                COLUMNS = {
                    'bucket_owner': 'VARCHAR',
                    'bucket': 'VARCHAR',
                    'time_part1': 'VARCHAR',
                    'time_part2': 'VARCHAR',
                    'remote_ip': 'VARCHAR',
                    'requester': 'VARCHAR',
                    'request_id': 'VARCHAR',
                    'operation': 'VARCHAR',
                    'key': 'VARCHAR',
                    'request_uri': 'VARCHAR',
                    'http_status': 'INT',
                    'error_code': 'VARCHAR',
                    'bytes_sent': 'INT',
                    'object_size': 'BIGINT',
                    'total_time_millis': 'INT',
                    'turn_around_time_millis': 'INT',
                    'referrer': 'VARCHAR',
                    'user_agent': 'VARCHAR',
                    'version_id': 'VARCHAR',
                    'host_id': 'VARCHAR',
                    'signature_version': 'VARCHAR',
                    'cipher_suite': 'VARCHAR',
                    'authentication_type': 'VARCHAR',
                    'host_header': 'VARCHAR',
                    'tls_version': 'VARCHAR',
                    'access_point_arn': 'VARCHAR',
                    'acl_required': 'VARCHAR'
                }
            )
    )
SELECT * EXCLUDE(time_part1, time_part2),
        strptime(
                right(time_part1, length(time_part1) -1) || left(time_part2, length(time_part2) -1),
                '%d/%b/%Y:%H:%M:%S%z'
        ) AS time,
       split_part(request_uri, ' ', 1) AS http_method,
       split_part(request_uri, ' ', 2) AS uri_stem,
       split_part(request_uri, ' ', 3) AS http_protocol
FROM log;