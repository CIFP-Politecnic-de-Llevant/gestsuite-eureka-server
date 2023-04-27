FROM maven:3-amazoncorretto-11 as build-stage
WORKDIR /resources
COPY . .
#ENTRYPOINT ["mvn", "clean", "compile", "install", "package"]
RUN mvn clean compile install package -f pom.xml

FROM amazoncorretto:11-alpine-jdk as production-stage
COPY --from=build-stage /resources/target/eureka-server-0.0.1-SNAPSHOT.jar eureka.jar
ENTRYPOINT ["java","-jar","/eureka.jar"]