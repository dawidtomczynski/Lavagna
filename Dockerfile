FROM maven:3.8.6-jdk-8 AS build
COPY ./project /project
WORKDIR /project
RUN mvn verify

FROM openjdk:8-jre-alpine
RUN mkdir lavagna
COPY --from=build /project/target /lavagna
WORKDIR /lavagna
RUN unzip lavagna-1.1.3-SNAPSHOT-distribution.zip
ENTRYPOINT ["java", "-Ddatasource.dialect=MYSQL", "-Ddatasource.url=jdbc:mysql://mysqldb:3306/lavagna?useSSL=false", "-Ddatasource.username=test6", "-Ddatasource.password=test", "-Dspring.profile.active=dev", "-jar", "lavagna-jetty-console.war"]
