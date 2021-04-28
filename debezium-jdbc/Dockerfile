FROM debezium/connect:1.0
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG POSTGRES_VERSION=42.2.8
ARG KAFKA_JDBC_VERSION=5.5.0

#RUN export https_proxy='http://squid:squid@10.11.23.50:8080'
#RUN export http_proxy='http://squid:squid@10.11.23.50:8080'

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

#RUN curl -sO https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.23.tar.gz

RUN curl -k -SL "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.37.tar.gz" | tar -xzf - -C /kafka/libs --strip-components=1 mysql-connector-java-5.1.37/mysql-connector-java-5.1.37-bin.jar

#ADD mysql-connector-java-5.1.37-bin.jar /kafka/libs

#copy mysql-connector-java-5.1.37-bin.jar /kafka/libs

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar
