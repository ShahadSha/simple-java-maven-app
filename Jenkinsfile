pipeline {
    agent any 
    environment {
        registry = "804669271496.dkr.ecr.us-east-2.amazonaws.com/maven-docker"
    }
    tools {
        maven 'MAVEN_HOME'
    }
    stages {
        stage("Build Maven") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ShahadSha/simple-java-maven-app']]])
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage("Build Docker Image") {
            steps {
                script {
                    sh 'docker build -t maven-docker .'
                }
            }
        }
        stage("AWS ECR Login") {
            steps {
                script {
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x3x3m9h6'
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

        stage("Cleaning Docker Images") {
            steps {
                script {
                    sh '''docker stop $(docker ps -aq)'''
                    sh '''docker rm $(docker ps -aq)'''
                    sh '''docker rmi $(docker images -q)'''
                    sh 'la'
                    
                }
            }
        }
    }
}