FROM maven:3-amazoncorretto-11 as develop-stage-eureka
COPY . .
RUN mvn clean install spring-boot:run -f pom.xml

FROM maven:3-amazoncorretto-11 as build-stage-eureka
WORKDIR /resources
COPY . .
RUN mvn clean compile install package -f pom.xml

FROM amazoncorretto:11-alpine-jdk as production-stage-eureka
COPY --from=build-stage-eureka /resources/target/eureka-server-0.0.1-SNAPSHOT.jar eureka.jar
ENTRYPOINT ["java","-jar","/eureka.jar"]