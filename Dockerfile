FROM openjdk:8-alpine

ENV SPARK_HOME=/opt/spark
ENV LIVY_HOME=/opt/livy
ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV SPARK_USER=ticksmith

ARG AWS_JAVA_SDK_VERSION=1.7.4
ARG HADOOP_AWS_VERSION=2.7.3
ARG LIVY_VERSION=0.6.0
ARG SPARK_VERSION=2.4.3

WORKDIR /opt

RUN apk add --update openssl wget bash && \
    wget -P /opt https://www.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    tar xvzf spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    rm spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    ln -s /opt/spark-$SPARK_VERSION-bin-hadoop2.7 /opt/spark


RUN wget -P ${SPARK_HOME}/jars http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/$HADOOP_AWS_VERSION/hadoop-aws-$HADOOP_AWS_VERSION.jar && \
    wget -P ${SPARK_HOME}/jars http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/$AWS_JAVA_SDK_VERSION/aws-java-sdk-$AWS_JAVA_SDK_VERSION.jar && \
    wget -P ${SPARK_HOME}/jars http://central.maven.org/maven2/com/microsoft/azure/azure-storage/7.0.0/azure-storage-7.0.0.jar && \
    wget -P ${SPARK_HOME}/jars http://central.maven.org/maven2/org/apache/hadoop/hadoop-azure/2.7.5/hadoop-azure-2.7.5.jar


RUN apk update && \
    echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
    

RUN pip3 install pyspark==$SPARK_VERSION


COPY req.txt /requirements.txt

RUN ["/usr/bin/pip3", "install", "-r", "/requirements.txt"]

