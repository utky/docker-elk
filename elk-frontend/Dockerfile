FROM centos:7
MAINTAINER Imamura Yutaka <ilyaletre@gmail.com>

ENV PLATFORM="linux-x64"
ENV KIBANA_VERSION="4.0.2"

RUN yum -y update && \
    yum install -y tar && \
    yum clean all

WORKDIR /var/lib

RUN curl -s -O https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-${PLATFORM}.tar.gz
RUN tar xzf kibana-${KIBANA_VERSION}-${PLATFORM}.tar.gz
RUN rm -f kibana-${KIBANA_VERSION}-${PLATFORM}.tar.gz
RUN mv kibana-${KIBANA_VERSION}-${PLATFORM} kibana

WORKDIR /

RUN mkdir -p /data /log /conf

VOLUME [""/log", "/conf"]

ADD kibana.yml /var/lib/kibana/config/kibana.yml

EXPOSE 5601

CMD /var/lib/kibana/bin/kibana
