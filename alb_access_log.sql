CREATE OR REPLACE TABLE alb_access_log AS WITH log AS (
        SELECT *
        FROM read_csv(
                '*',
                delim = ' ',
                nullstr = '-',
                header = FALSE,
                auto_detect = FALSE,
                -- conn_trace_id is missing for certain logs at times
                null_padding = TRUE,
                COLUMNS = {
                    'type': 'VARCHAR',
                    'time': 'timestamp',
                    'elb': 'VARCHAR',
                    'client': 'VARCHAR',
                    'target': 'VARCHAR',
                    'request_processing_time': 'double',
                    'target_processing_time': 'double',
                    'response_processing_time': 'double',
                    'elb_status_code': 'int',
                    'target_status_code': 'VARCHAR',
                    'received_bytes': 'bigint',
                    'sent_bytes': 'bigint',
                    'request_uri': 'VARCHAR',
                    'user_agent': 'VARCHAR',
                    'ssl_cipher': 'VARCHAR',
                    'ssl_protocol': 'VARCHAR',
                    'target_group_arn': 'VARCHAR',
                    'trace_id': 'VARCHAR',
                    'domain_name': 'VARCHAR',
                    'chosen_cert_arn': 'VARCHAR',
                    'matched_rule_priority': 'VARCHAR',
                    'request_creation_time': 'TIMESTAMP',
                    'actions_executed': 'VARCHAR',
                    'redirect_url': 'VARCHAR',
                    'lambda_error_reason': 'VARCHAR',
                    'target_port_list': 'VARCHAR',
                    'target_status_code_list': 'VARCHAR',
                    'classification': 'VARCHAR',
                    'classification_reason': 'VARCHAR',
                    'conn_trace_id': 'VARCHAR'
                }
        )
)
SELECT * EXCLUDE(request_uri),
        split_part(request_uri, ' ', 1) AS http_method,
        split_part(request_uri, ' ', 2) AS request_uri,
        split_part(request_uri, ' ', 3) AS http_protocol
FROM log;