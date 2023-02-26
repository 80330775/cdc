curl -X POST http://$HOST:8083/connectors \
  -H 'Accept:application/json' \
  -H 'Content-Type:application/json' \
  -d '{
	"name": "debezium",
	"config": {
		"connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
		"database.hostname": "mysql",
		"database.port": "3306",
		"database.user": "debezium",
		"database.password": "123456",
		"database.server.id": "1000",
		"database.include.list": "'${PROJECT}'",
		"table.include.list": "'${PROJECT}'.test",
		"message.key.columns": "'${PROJECT}'.test:id",
		"topic.prefix": "debezium",
		"topic.delimiter": "-",
		"schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
		"schema.history.internal.kafka.topic": "'${PROJECT}'-schemahistory-debezium",
		"predicates": "isChangeEvent",
		"predicates.isChangeEvent.type": "org.apache.kafka.connect.transforms.predicates.TopicNameMatches",
		"predicates.isChangeEvent.pattern": "debezium-'${PROJECT}'-.*",
    "transforms": "unwrap,extractKey",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones": false,
		"transforms.unwrap.predicate": "isChangeEvent",
		"transforms.extractKey.type": "org.apache.kafka.connect.transforms.ExtractField$Key",
		"transforms.extractKey.field": "id",
		"transforms.extractKey.predicate": "isChangeEvent"
	}
}'
