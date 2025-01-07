FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim


EXPOSE 8070

COPY --from=build target/WalletCryptoService-0.0.1-SNAPSHOT.jar app.jar



# Run the Config Server application
ENTRYPOINT ["java", "-jar", "app.jar"]
