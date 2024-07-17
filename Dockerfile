# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the application JAR file to the container
COPY target/Hello-DB-APP.jar

# Download and install the New Relic Java agent
RUN mkdir -p /newrelic
RUN wget -O /newrelic/newrelic.jar https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip && \
    unzip /newrelic/newrelic-java.zip -d /newrelic && \
    rm /newrelic/newrelic-java.zip

# Copy the New Relic configuration file
COPY newrelic/newrelic.yml /newrelic/newrelic.yml

# Set the New Relic license key as an environment variable
ENV NEW_RELIC_LICENSE_KEY=your_license_key

# Run the application with the New Relic agent
ENTRYPOINT ["java", "-javaagent:/newrelic/newrelic.jar", "-jar", "app.jar"]
