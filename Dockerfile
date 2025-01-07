FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim


# Expose the port used by the Config Server
EXPOSE 8070

# Copy the jar file of the Config Server application into the container
COPY --from=build target/WalletCryptoService-0.0.1-SNAPSHOT.jar app.jar



# Run the Config Server application
ENTRYPOINT ["java", "-jar", "app.jar"]
