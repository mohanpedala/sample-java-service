FROM openjdk:8-jre-alpine
MAINTAINER Mohan.edala@binarybutter.com

WORKDIR /app

# Truststore
#ENV DJAVAX_NET_SSL_TRUSTSTORE /keystore/DevTrustStore

# Spring profile env
#ENV SPRING_PROFILES_ACTIVE qa

# Copying file from host machine to image in /app directory which is created above
COPY target/sample-java-service-0.0.1-SNAPSHOT.jar sample-java-service-0.0.1-SNAPSHOT.jar

# Providing permission to /app directory
RUN chmod +x -R /app

# Exposing container port
EXPOSE 8080

# This CMD is to register the container to eureka
# CMD ["java", "-jar", "/app/sample-java-service-0.0.1-SNAPSHOT.jar", "--eureka.instance.hostname=localhost:80"]

CMD ["java", "-jar", "/app/sample-java-service-0.0.1-SNAPSHOT.jar"]