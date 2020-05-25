# Kafka and Zookeeper

FROM openjdk:11-jre

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.5.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Install Kafka, Zookeeper and other needed things
RUN apt-get update && \
    apt-get install -y zookeeper wget supervisor dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    cd /tmp && \
    wget -q http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    echo "447A7057BCD9FACA98B6F4807BD6019EF73EEE90EFDC1E7B10005F669E2537A8A190CB8B9C9F4C20DB1D95B13D0F0487E9CC560D0759532058439CE7F722C7CD kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz" | sha512sum -c - && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh

# Supervisor config
ADD supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/

# 2181 is zookeeper, 9092 or 9093 is kafka
# Because of Kafka metadata announcement, the internal port must be equal to the mapped external port.
# In development environment, multiple Kafkas must be mapped to different ports.
# So, we expose all ports that are used in any of our Kafka instances.
# A Kafka container will be configured to bind to its port via a mounted config file.
# The other exposed Kafka ports are not bound by the container and cannot be connected.
# This is a pretty ugly hack but fits best into our deploy environment.
# Other possible hacks are even worse.
EXPOSE 2181 9092 9093

CMD ["supervisord", "-n"]
