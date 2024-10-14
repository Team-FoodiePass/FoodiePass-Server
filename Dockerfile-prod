FROM amazoncorretto:21-alpine-jdk
WORKDIR /app
COPY build/libs/foodiepass-server-0.0.1-SNAPSHOT.jar /app/foodiepass-server.jar
CMD ["java", "-Duser.timezone=Asia/Seoul", "-jar", "-Dspring.profiles.active=prod", "foodiepass-server.jar"]
