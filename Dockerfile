FROM wangwii/systemd-sshd-jdk:latest
LABEL maintainer "Wang Wei - https://github.com/wangwii"

# Upgrade base OS
RUN yum -y update

# Install Spark(https://spark.apache.org/downloads.html)
ENV HADOOP_VERSION=2.7
ENV SPARK_VERSION=2.3.1
ENV SPARK_PACKAGE="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}"
ENV SPARK_HOME="/opt/apache/${SPARK_PACKAGE}"
RUN curl -kL -o "${SPACK_PACKAGE}.tgz" \
            "http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" && \
        mkdir -p "${SPARK_HOME}" && \
        tar -xzf "${SPACK_PACKAGE}.tgz" -C "${SPARK_HOME}/../"  && \
        rm -rf "${SPACK_PACKAGE}.tgz"

# Install Scala(https://www.scala-lang.org/download/)
ENV SCALA_VERSION=2.11.12
ENV SCALA_PACKAGE="scala-${SCALA_VERSION}"
ENV SCALA_HOME="/opt/scala/${SCALA_PACKAGE}"
RUN curl -kL -o "${SCALA_PACKAGE}.tgz" "https://www.scala-lang.org/files/archive/${SCALA_PACKAGE}.tgz" && \
        mkdir -p "${SCALA_HOME}" && \
        tar -xzf "${SCALA_PACKAGE}.tgz" -C "${SCALA_HOME}/../"  && \
        rm -rf "${SCALA_PACKAGE}.tgz"

ENV PATH=$SPARK_HOME/bin:$SCALA_HOME/bin:$PATH
