This repo push a minimum jenkins image with drone support to docker hub as azuruce/jenkins-drone:lts-alpine
The jenkins image will run best in k8s. It runs with DooD, set docker user to group 1001, and use PDT timezone

To run this
 - install docker ce
 - install drone cli
 - run `DOCKER_USERNAME=xxx DOCKER_PASSWORD=xxx drone exec` 
