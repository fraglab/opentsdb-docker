#!/bin/bash

echo "Sleeping for 30 seconds to give HBase time to warm up"
bash -c "sleep 30"

if [ ! -e /opt/opentsdb_tables_created.txt ]; then
        echo "creating tsdb tables"
        bash -c "/opt/bin/create_tsdb_tables.sh"
        echo "created tsdb tables"
fi

echo "starting opentsdb"
bash -c "/usr/share/opentsdb/bin/tsdb tsd"
