FROM centos:7
MAINTAINER Imamura Yutaka <ilyaletre@gmail.com>

ENV JDK_VERSION="1.7.0"
ENV ES_VERSION="1.5.1"
ENV LOGSTASH_VERSION="1.4.2"

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update && \
    yum install -y java-${JDK_VERSION}-openjdk tar supervisor python-setuptools && \
    easy_install supervisor && \
    yum clean all


WORKDIR /var/lib

RUN curl -s -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz
RUN tar xzf elasticsearch-${ES_VERSION}.tar.gz
RUN rm -f elasticsearch-${ES_VERSION}.tar.gz
RUN mv elasticsearch-${ES_VERSION} elasticsearch

RUN curl -s -O https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz
RUN tar xzf logstash-${LOGSTASH_VERSION}.tar.gz
RUN rm -f logstash-${LOGSTASH_VERSION}.tar.gz
RUN mv logstash-${LOGSTASH_VERSION} logstash

WORKDIR /

ADD supervisord.conf /etc/supervisord.conf
RUN mkdir -p /etc/supervisor/conf.d
ADD elk.conf /etc/supervisor/conf.d/elk.conf


RUN mkdir -p /data /log

VOLUME ["/data", "/log"]

EXPOSE 9200 9300

CMD /usr/bin/supervisord