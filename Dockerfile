FROM eclipse-temurin:17 AS build

WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew bootjar --no-daemon

# Run stage
FROM eclipse-temurin:17
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/build/libs/renderapp-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
