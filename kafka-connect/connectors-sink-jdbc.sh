curl -X POST http://$HOST:8083/connectors \
  -H 'Accept:application/json' \
  -H 'Content-Type:application/json' \
  -d '{
	"name": "jdbc-sink",
	"config": {
    "topics.regex": "debezium-'${PROJECT}'-.*",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
		"connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
		"connection.url": "jdbc:mysql://mysql:3306/'${PROJECT}'_sink",
		"connection.user": "root",
		"connection.password": "123456",
		"insert.mode": "upsert",
		"delete.enabled": true,
		"table.name.format": "${topic}_sink",
		"pk.mode": "record_key",
		"pk.fields": "id",
		"auto.create": false,
		"auto.evolve": false,
		"transforms": "dropPrefix",
		"transforms.dropPrefix.type": "org.apache.kafka.connect.transforms.RegexRouter",
		"transforms.dropPrefix.regex": "debezium-'${PROJECT}'-(.*)",
		"transforms.dropPrefix.replacement": "$1"
	}
}'
