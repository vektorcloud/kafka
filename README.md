# kafka
[![Circle CI](https://circleci.com/gh/vektorcloud/kafka.svg?style=svg)](https://circleci.com/gh/vektorcloud/kafka)

Tiny Alpine image for running [Apache Kafka](http://kafka.apache.org/) with [Kafka Manager](https://github.com/yahoo/kafka-manager).

### Building

You need to build the kafka-manager prior to building the docker image


    docker run --rm -ti -v $PWD/kafka-manager:/target -w /target quay.io/vektorcloud/build sbt clean dist
    docker build -t quay.io/vektorcloud/kafka .
