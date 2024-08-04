CREATE OR REPLACE TABLE nlb_access_log AS
SELECT *
FROM read_csv(
        -- path to files, currently it loads all files in local dir, you may want to change this
        '*',
        delim = ' ',
        nullstr = '-',
        header = FALSE,
        auto_detect = FALSE,
        null_padding = TRUE,
        quote='',
        COLUMNS = {
            'type': 'VARCHAR',
            'version': 'VARCHAR',
            'time': 'timestamp',
            'elb': 'VARCHAR',
            'listener': 'VARCHAR',
            'client': 'VARCHAR',
            'target': 'VARCHAR',
            'connection_time_millis': 'int',
            'tls_handshake_time_millis': 'int',
            'received_bytes': 'int',
            'sent_bytes': 'int',
            'incoming_tls_alert': 'int',
            'chosen_cert_arn': 'VARCHAR',
            'chosen_cert_serial': 'VARCHAR',
            'tls_cipher': 'VARCHAR',
            'tls_protocol_version': 'VARCHAR',
            'tls_named_group': 'VARCHAR',
            'domain_name': 'VARCHAR',
            'alpn_fe_protocol': 'VARCHAR',
            'alpn_be_protocol': 'VARCHAR',
            'alpn_client_preference_list': 'VARCHAR',
            'tls_connection_creation_time': 'timestamp'
        }
);