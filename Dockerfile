FROM gradle:8.14-jdk17-alpine AS BUILD
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test

FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar /app/notificacao.jar
EXPOSE 8082
CMD ["java", "-jar", "/app/notificacao.jar"]