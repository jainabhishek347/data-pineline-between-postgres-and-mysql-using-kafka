## Build a Data pipe line using Kafka for Postgres and MySQL.

## Project summary

We will use Kafka connect to capture changes in the Employees and departments table from postgres database and write to a Kafka topic. Two connectors will subscribe to the topic, and write any changes MySQL database.

## Project architecture


## Instructions
* Clone the repo to your local machine
* Install docker and docker-compose
* Start docker continsers for Kafka, Zookeeper, MySQL, Postgres, Kafdrop, Schema Registery, Kafka connect
    
         docker-compose -f docker-compose.yml up -d
* Wait a few minutes for the services to start up. You can view logs outputs using:

        docker-compose -f docker-compose.yml logs -f

## Kafdrop UI : 
 * http://localhost:9000/
 
 ![kafdropui](images/kafdrop.png?raw=true)
 ![kafdropui](images/kafdrop-2.png?raw=true)


## MONITORING control center: 
 * http://localhost:9021
 
 ![kafka control center](images/kafka-control-center.png?raw=true)

## Schema-registry-ui:

 * http://localhost:8000


## Configure source connector:

 * Execute curl commands give in connector's folder for source and sink connector respectively.

 * Example: Create source connector for postgres departments table

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

    curl -X GET   http://localhost:8084/connectors/postgresql_departments_source_connector/status -H 'Cache-Control: no-cache' -H 'Content-Type: application/json'

## Delete connector:

    curl -X DELETE http://localhost:8084/connectors/postgresql_departments_source_connector -H 'Cache-Control: no-cache'   -H 'Content-Type: application/json'


## Pause a connector:

    curl -X DELETE http://localhost:8084/connectors/postgresql_departments_source_connector -H 'Cache-Control: no-cache'   -H 'Content-Type: application/json'

## Resume a connector:

    curl -X PUT http://localhost:8084/connectors/postgresql_departments_source_connector/resume -H 'Cache-Control: no-cache' -H 'Content-Type: application/json'


## Docker volume status:
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

## Remove specific volume
    docker volume rm postgres-data

## Remove all volumes
    docker volume rm $(docker volume ls -q)


## Print Postgres DB queries in logs for deugging

    docker logs -f postgresql

## Clean up
If you don't have any other docker containers running, you can shut down the ones for this project with the following command:

    docker stop $(docker ps -aq)

Optionally, you can clean up docker images downloaded locally by rinning:

    docker system prune