pipeline {
    agent any 
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
                     dockerImage = docker.build 804669271496..dkr.ecr.us-east-2.amazonaws.com
                    //sh 'docker build -t shahadsha/pipelinetester:${BUILD_NUMBER} .'
                }
            }
        }
        // login to aws ECR
        stage("AWS ECR Login") {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 804669271496..dkr.ecr.us-east-2.amazonaws.com'
                }
            }
        }
        stage("AWS ECR Push") {
            steps {
                script {
                    sh 'docker tag ${BUILD_NUMBER} 804669271496.dkr.ecr.us-east-2.amazonaws.com/maven-docker:${BUILD_NUMBER}'
                    sh 'docker push 804669271496.dkr.ecr.us-east-2.amazonaws.com/maven-docker:${BUILD_NUMBER}'
                }
            }
        }

        stage("push to docker hub") {
            steps {
                withCredentials([
                    string(credentialsId: 'dockerusername', variable: 'dockerusr'),
                    string(credentialsId: 'shahadshaa', variable: 'dockerva')]) {
                        sh 'docker login -u ${dockerusr} -p ${dockerva}'  
                        sh 'docker push shahadsha/pipelinetester:${BUILD_NUMBER}'
                        sh 'docker logout'
                        }
            }
        }
    }
}