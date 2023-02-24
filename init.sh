#!/bin/bash -e
if [ -z $DATA_DIR ]; then
  echo "required variable DATA_DIR is missing"
  exit 1
fi

if [ -z $HOST ]; then
  echo "required variable HOST is missing"
  exit 1
fi

if [ ! -d $DATA_DIR/zookeeper ]; then
  mkdir -p $DATA_DIR/zookeeper && chown -R 1000:1000 $DATA_DIR/zookeeper
fi

if [ ! -d $DATA_DIR/kafka ]; then
  mkdir -p $DATA_DIR/kafka && chown -R 1000:1000 $DATA_DIR/kafka
fi

if [ ! -d $DATA_DIR/mysql ]; then
  mkdir -p $DATA_DIR/mysql && chown -R 1000:1000 $DATA_DIR/mysql
fi
