pipeline {
    agent any 
    tools {
        maven 'maven_local'
    }
    stages {
        stage("Build maven") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'shahadsha', url: 'https://github.com/ShahadSha/simple-java-maven-app.git']]])
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        
        stage("build docker image") {
            steps {
                script {
                    sh 'docker build -t shahadsha/pipelinetester:${BUILD_NUMBER} .'
                }
            }
        }
        stage("push to docker hub") {
            steps {
                withCredentials([string(credentialsId: 'shahadshaa', variable: 'dockerva')]) {
                sh 'docker login -u shahadsha -p ${dockerva}'  
                sh 'docker push shahadsha/pipelinetester:${BUILD_NUMBER}'
                sh 'docker logout'
}
            }
        }
    }
}