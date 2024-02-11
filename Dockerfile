# Use the official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to the root user for administrative tasks
USER root

# Install necessary tools and dependencies
RUN apt-get update && \
    apt-get install -y sudo

# Switch back to the Jenkins user
USER jenkins

# Install Jenkins plugins using the install-plugins.sh script
RUN /usr/local/bin/install-plugins.sh \
    blueocean

# Expose the default Jenkins port
EXPOSE 8080

# Copy default Jenkins configurations to skip setup wizard
COPY --chown=jenkins:jenkins config/* /usr/share/jenkins/ref/

# Set environment variables to skip initial setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Command to run Jenkins
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
