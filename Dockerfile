# Stage 1: Build — cache Maven deps separately for fast rebuilds
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app

# Cache dependencies layer (only re-downloads if pom.xml changes)
COPY pom.xml .
RUN mvn dependency:go-offline -q

# Build
COPY src ./src
RUN mvn clean package -DskipTests -q

# Stage 2: Minimal Tomcat runtime
FROM tomcat:9.0-jdk11-temurin-jammy
WORKDIR /usr/local/tomcat

# Remove default apps
RUN rm -rf webapps/* webapps.dist

# Tune Tomcat for performance: GZIP, threads, keep-alive
RUN sed -i 's|<Connector port="8080" protocol="HTTP/1.1"|<Connector port="8080" protocol="HTTP/1.1"\n               maxThreads="200" minSpareThreads="20"\n               compression="on" compressionMinSize="1024"\n               compressibleMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"\n               keepAliveTimeout="15000"|' conf/server.xml

# Tune JVM: G1GC, smaller heap for free tier (512MB RAM)
ENV JAVA_OPTS="-server -Xms128m -Xmx384m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+OptimizeStringConcat -Djava.security.egd=file:/dev/./urandom"

# Deploy WAR as ROOT (no path prefix needed)
COPY --from=build /app/target/ECommerceSystem.war webapps/ROOT.war

EXPOSE 8080
CMD ["sh", "-c", "sed -i \"s/8080/${PORT:-8080}/g\" conf/server.xml && catalina.sh run"]
