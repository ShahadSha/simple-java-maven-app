pipeline {
    agent any 
    environment {
        registry = "804669271496.dkr.ecr.us-east-2.amazonaws.com/maven-docker"
    }
    tools {
        maven 'MAVEN_HOME'
    }
    stages {
        stage("Build maven") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ShahadSha/simple-java-maven-app']]])
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

        stage("build docker image") {
            steps {
                script {
                    docker build -t maven-docker .
                }
            }
        }

        stage("AWS ECR Login") {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 804669271496.dkr.ecr.us-east-2.amazonaws.com'
                }
            }
        }
        stage("AWS ECR Push") {
            steps {
                script {
                    sh 'docker tag maven-docker:latest public.ecr.aws/x3x3m9h6/maven-docker:${BUILD_NUMBER}'
                    sh 'docker push public.ecr.aws/x3x3m9h6/maven-docker:${BUILD_NUMBER}'

                    
                }
            }
        }

    }
}