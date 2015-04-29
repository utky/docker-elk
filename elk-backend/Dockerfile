FROM centos:7
MAINTAINER Imamura Yutaka <ilyaletre@gmail.com>

ENV JDK_VERSION="1.7.0"
ENV ES_VERSION="1.5.1"
ENV LOGSTASH_VERSION="1.4.2"

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && \
    yum install -y java-${JDK_VERSION}-openjdk tar supervisor python-setuptools rsyslog && \
    easy_install supervisor && \
    mkdir -p /etc/supervisor/conf.d && \
    mkdir -p /data /log /conf && \
    yum clean all


WORKDIR /var/lib

RUN curl -s -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz && \
    tar xzf elasticsearch-${ES_VERSION}.tar.gz && \
    rm -f elasticsearch-${ES_VERSION}.tar.gz && \
    mv elasticsearch-${ES_VERSION} elasticsearch

RUN curl -s -O https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz && \
    tar xzf logstash-${LOGSTASH_VERSION}.tar.gz && \
    rm -f logstash-${LOGSTASH_VERSION}.tar.gz && \
    mv logstash-${LOGSTASH_VERSION} logstash && \
    /var/lib/logstash/bin/plugin install contrib

WORKDIR /


VOLUME ["/data", "/log", "/conf"]

ADD supervisord.conf /etc/supervisord.conf
ADD elk-backend.conf /etc/supervisor/conf.d/elk-backend.conf
ADD elasticsearch/elasticsearch.yml /conf/elasticsearch.yml
ADD elasticsearch/logging.yml /conf/logging.yml
ADD logstash/logstash.conf /conf/logstash.conf
ADD rsyslog.conf /etc/rsyslog.conf

EXPOSE 9200 9300 514

CMD /usr/bin/supervisord
