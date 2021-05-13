## Data pipe line between Postgres to MySQL  

## Kafdrop UI : 
 * http://localhost:9000/ *

## MONITORING control center: 
 * http://localhost:9021 *

## Schema-registry-ui:

 * http://localhost:8000 *

##
 * docker volume *
docker volume inspect kafka_mysql_to_postgres_sync_postgresVolume
[
    {
        "CreatedAt": "2021-05-05T09:31:23Z",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "kafka_mysql_to_postgres_sync",
            "com.docker.compose.version": "1.29.1",
            "com.docker.compose.volume": "postgresVolume"
        },
        "Mountpoint": "/var/lib/docker/volumes/kafka_mysql_to_postgres_sync_postgresVolume/_data",
        "Name": "kafka_mysql_to_postgres_sync_postgresVolume",
        "Options": null,
        "Scope": "local"
    }
]
*

## Remove specific
docker volume rm postgres-data

docker volume rm $(docker volume ls -q)


## Create source connector for postgres table

curl -X POST \
  http://localhost:8084/connectors/ \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "postgresql_departments_source_connector",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "tasks.max": "1",        
        "topic.prefix": "dummy_",
        "connection.url": "jdbc:postgresql://postgresql:5432/test_db",
        "connection.user": "test_user",
        "connection.password": "Welcome123",
        "mode": "timestamp+incrementing",
        "incrementing.column.name": "id",
        "timestamp.column.name": "updated_at",
        "value.converter.schema.registry.url": "http://schema-registry:8081",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": "true",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "key.converter.schemas.enable": "false",
        "validate.non.null": "false",
        "table.whitelist" : "departments"
      }
  }'

## Check connector status:

* curl -X GET   http://localhost:8084/connectors/postgresql_departments_source_connector/status -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' *

## Delete connector:

* curl -X DELETE http://localhost:8084/connectors/postgresql_departments_source_connector -H 'Cache-Control: no-cache'   -H 'Content-Type: application/json' *


## Pause a connector:

* curl -X DELETE http://localhost:8084/connectors/postgresql_departments_source_connector -H 'Cache-Control: no-cache'   -H 'Content-Type: application/json' *

## Resume a connector:

* curl -X PUT http://localhost:8084/connectors/postgresql_departments_source_connector/resume -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' * 

## Postgres DB logs for all queries

* docker logs -f  postgresql *
