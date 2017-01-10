FROM quay.io/vektorcloud/openjdk:latest

RUN VERSION=0.10.1.1 && \
  apk update && \
  apk add --no-cache gpgme bash openssl && \
  apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add dumb-init && \
  mkdir /opt && \
  cd /tmp && \
  wget "https://www-us.apache.org/dist/kafka/KEYS" && \
  gpg --import KEYS && \
  wget "https://www-us.apache.org/dist/kafka/$VERSION/kafka_2.11-$VERSION.tgz.asc" && \
  wget "https://www-us.apache.org/dist/kafka/$VERSION/kafka_2.11-$VERSION.tgz" && \
  gpg --verify "kafka_2.11-$VERSION.tgz.asc" "kafka_2.11-$VERSION.tgz" && \
  tar xvf "/tmp/kafka_2.11-$VERSION.tgz" -C /opt && \
  ln -sv /opt/kafka* /opt/kafka && \
  rm -v /tmp/kafka*

COPY kafka-manager/target/universal /target

RUN cd /opt && \
  unzip /target/kafka-manager* && \
  ln -sv kafka-manager* /opt/kafka-manager && \
  rm -Rvf /target/

ENV PATH "$PATH:/opt/kafka/bin:/opt/kafka-manager/bin"

COPY entrypoint.sh /
