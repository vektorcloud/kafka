FROM quay.io/vektorcloud/oracle-jre:latest

RUN VERSION=0.10.1.1 && \
  apk update && \
  apk add --no-cache gpgme bash && \
  apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add dumb-init && \
  cd /tmp && \
  wget "https://www-us.apache.org/dist/kafka/KEYS" && \
  gpg --import KEYS && \
  wget "https://www-us.apache.org/dist/kafka/$VERSION/kafka_2.11-$VERSION.tgz.asc" && \
  wget "https://www-us.apache.org/dist/kafka/$VERSION/kafka_2.11-$VERSION.tgz" && \
  gpg --verify "kafka_2.11-$VERSION.tgz.asc" "kafka_2.11-$VERSION.tgz" && \
  tar xvf "/tmp/kafka_2.11-$VERSION.tgz" -C /opt && \
  ln -sv /opt/kafka* /opt/kafka && \
  rm -v /tmp/kafka*

WORKDIR /opt/kafka
ENV PATH "$PATH:/opt/kafka/bin"

COPY entrypoint.sh /
