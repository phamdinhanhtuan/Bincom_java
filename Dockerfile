# Stage 1: Build the Maven project
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
# Prefetch dependencies to speed up subsequent builds
RUN mvn dependency:go-offline
COPY src ./src
# Build package (producing target/ECommerceSystem.war)
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat and deploy the WAR
FROM tomcat:9.0-jdk11-temurin
WORKDIR /usr/local/tomcat

# Delete default Tomcat webapps to save resources
RUN rm -rf webapps/*

# Copy built WAR file from Stage 1 as ROOT.war to serve at "/"
COPY --from=build /app/target/ECommerceSystem.war webapps/ROOT.war

# Render provides the port in the $PORT environment variable.
# Tomcat by default listens on 8080.
# We will use a script to replace 8080 with $PORT in conf/server.xml when starting the container.
EXPOSE 8080

CMD ["sh", "-c", "sed -i \"s/8080/${PORT:-8080}/g\" conf/server.xml && catalina.sh run"]
