FROM openjdk:8

ARG JAR_PATH

ENV SSLV3_JAR $JAR_PATH

MAINTAINER GoCD

VOLUME /opt/citruspay

COPY target/$SSLV3_JAR /opt/sslv3/SSLV3.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/opt/sslv3/SSLV3.jar" ,"&"]

EXPOSE 9051