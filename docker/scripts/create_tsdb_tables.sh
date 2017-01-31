#!/bin/bash

export COMPRESSION="NONE"
export HBASE_HOME=/opt/hbase

/usr/share/opentsdb/tools/create_table.sh; touch /opt/opentsdb_tables_created.txt