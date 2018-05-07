FROM golang:1.9 as builder

ARG DRONE_CLI_VERSION=v0.8.5
ARG DRONE_CLI_REPO=github.com/drone/drone-cli
ARG DRONE_CLI_PACKAGE=$DRONE_CLI_REPO/drone

RUN set -x \
 && go get -v -d "$DRONE_CLI_PACKAGE" \
 && cd "$GOPATH/src/$DRONE_CLI_REPO" \
 && git checkout --detach \
 && git reset --hard "$DRONE_CLI_VERSION" \
 && git clean -df \
 && CGO_ENABLED=0 go build -a \
      -ldflags "-X main.version=${DRONE_CLI_VERSION##v} -s -extldflags '-static'" \
      -o /usr/local/bin/drone \
      "$DRONE_CLI_PACKAGE"

FROM jenkins/jenkins:lts-alpine
LABEL maintainer="azuruce@gmail.com"
USER root
COPY --from=builder /usr/local/bin/drone /usr/local/bin/drone
RUN apk update
RUN apk add docker
# docker group should have gid of 1001 instead of 101
RUN sed -ie "s/docker:x:101/docker:x:1001/g" /etc/group
# jenkins user should be in docker group
RUN adduser jenkins docker
USER jenkins
