FROM openjdk:8-jdk

ENV TSDB_VERSION 2.3.0
ENV HBASE_VERSION 1.2.4

WORKDIR /tmp

RUN apt-get update &&\
    apt-get install -y --no-install-recommends vim gnuplot make autoconf supervisor dos2unix &&\
    apt-get autoclean &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    mkdir -p /opt/bin \
             /opt/hbase \
             /data/hbase \
             /var/log/supervisor \
             /root/.profile.d &&\
    wget http://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    tar xzvf hbase-${HBASE_VERSION}-bin.tar.gz && \
    mv hbase-${HBASE_VERSION}/* /opt/hbase && \
    rm hbase-${HBASE_VERSION}-bin.tar.gz && \
    wget https://github.com/OpenTSDB/opentsdb/releases/download/v${TSDB_VERSION}/opentsdb-${TSDB_VERSION}_all.deb && \
    dpkg -i opentsdb-${TSDB_VERSION}_all.deb && \
    rm -rf opentsdb-${TSDB_VERSION}_all.deb

COPY docker/hbase-site.xml /opt/hbase/conf/hbase-site.xml
COPY docker/opentsdb.conf /etc/opentsdb/opentsdb.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/scripts/ /opt/bin/

WORKDIR /opt/bin

RUN chmod +x /opt/bin/* && ls /opt/bin/ | xargs dos2unix

EXPOSE 60000 60010 60030 4242 16010

VOLUME ["/data/hbase", "/tmp"]

CMD ["/usr/bin/supervisord"]
