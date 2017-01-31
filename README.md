# opentsdb-docker

Simple OpenTSDB dockerfile useful for work with Grafana.

**Features:**

* Image based on prepared java image: openjdk:8-jdk
* Except opentsdb and hbase all dependency installed with apt-get
* Use supervisord as runner
 
 
**How image work, step by step:**

* Start Hbase
* Start OpenTSDB
  * wait 30 sec for hbase started
  * creating tsdb tables
  * starting OpenTSDB
* Supervisor restart opentsdb-uid-metasync with 60 sec interval


OpenTSDB uid metasync need for work with Grafana templates.