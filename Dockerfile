FROM maven:3.8.6-jdk-11

WORKDIR /simple-java-maven-app

COPY src /usr/src/app/src 

COPY pom.xml /tmp/pom.xml

RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

