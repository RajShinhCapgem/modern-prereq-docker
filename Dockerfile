# Start with a base image that includes essential tools
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Java 8 and Java 21 using SDKMAN!
USER root
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl zip unzip \
    && curl -s "https://get.sdkman.io" | bash \
    && bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.412-tem && sdk install java 21.0.3-tem"

# Install .NET 9
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel 9.0 -i /usr/local/dotnet

# Install Maven and Gradle using SDKMAN!
RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install maven && sdk install gradle"

# Set environment variables to make tools accessible
ENV JAVA_HOME_8=/root/.sdkman/candidates/java/8.0.412-tem
ENV JAVA_HOME_21=/root/.sdkman/candidates/java/21.0.3-tem
ENV PATH="/root/.sdkman/candidates/maven/current/bin:/root/.sdkman/candidates/gradle/current/bin:/usr/local/dotnet:${PATH}"

# Default to Java 21, but allow easy switching
ENV JAVA_HOME=$JAVA_HOME_21