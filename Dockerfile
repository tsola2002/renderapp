FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew bootJar --no-daemon

#RUN STAGE
FROM eclipse-temurin:17
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/build/libs/renderapp-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

