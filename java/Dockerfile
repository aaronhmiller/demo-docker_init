# syntax=docker/dockerfile:1
################################################################################
# Create a stage for resolving and downloading dependencies.
FROM eclipse-temurin:21-jdk-jammy AS deps
WORKDIR /build
# Copy the mvnw wrapper with executable permissions.
COPY --chmod=0755 mvnw mvnw
COPY .mvn/ .mvn/
# Download dependencies as a separate step to take advantage of Docker's caching.
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 ./mvnw dependency:go-offline -DskipTests
################################################################################
# Create a stage for building the application
FROM deps as package
WORKDIR /build
COPY ./src src/
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw package -DskipTests
################################################################################
# Create a stage for running the application using official Tomcat image
FROM tomcat:9-jre21-temurin-jammy AS final

# Create a non-privileged user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR from the "package" stage to Tomcat webapps directory
COPY --from=package /build/target/hello-world-webapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Make sure Tomcat can access the files
RUN chown -R appuser:appuser /usr/local/tomcat

# Switch to non-root user
USER appuser

# Expose Tomcat port
EXPOSE 8080

# The entrypoint and CMD are inherited from the tomcat image
