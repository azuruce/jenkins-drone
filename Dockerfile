FROM jenkins/jenkins:lts-alpine
LABEL maintainer="azuruce@gmail.com"
RUN curl -L https://github.com/drone/drone-cli/releases/download/v0.8.5/drone_linux_amd64.tar.gz | tar -zx -C /tmp
USER root
RUN install -t /usr/local/bin /tmp/drone
USER jenkins