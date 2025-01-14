
# Building and Deploying a maven project into Kubernetes

## Pipeline
- Cloning github repo
- Sonarqube analysis
- Quality gate
- Building docker image with kaniko
- Triggering another pipeline with build number parameter
- Deploying springboot application into Kubernetes


The repository contains a simple Java application which outputs the string
"Hello world!" and is accompanied by a couple of unit tests to check that the
main application works as expected. The results of these tests are saved to a
JUnit XML report.

The `jenkins` directory contains an example of the `Jenkinsfile` (i.e. Pipeline)
you'll be creating yourself during the tutorial and the `scripts` subdirectory
contains a shell script with commands that are executed when Jenkins processes
the "Deliver" stage of your Pipeline.
