FROM jenkins/jenkins:lts-alpine
LABEL maintainer="azuruce@gmail.com"
USER root
RUN cat /etc/apk/repositories
RUN apk update
RUN apk add docker
RUN curl -L https://github.com/drone/drone-cli/releases/download/v0.8.5/drone_linux_amd64.tar.gz | tar -zx -C /tmp
RUN install -t /usr/local/bin /tmp/drone
# docker group should have gid of 1001 instead of 101
RUN sed -ie "s/docker:x:101/docker:x:1001/g" /etc/group
# jenkins user should be in docker group
RUN adduser jenkins docker
USER jenkins
