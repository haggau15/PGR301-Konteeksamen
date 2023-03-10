FROM maven:3.9-jdk-17 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package

FROM adoptopenjdk/openjdk17:alpine-slim
COPY --from=builder /app/target/*.jar /app/application.jar
ENTRYPOINT ["java","-jar","/app/application.jar"]