pipeline {
    agent any 
    
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

        stage("cloning Repo again") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ShahadSha/simple-java-maven-app']]])
            }
        }

        stage("pushing") {
            steps {
                sh 'cd java-helm'
                def datas = readYaml file:"Chart.yml"
                datas = ['version': '${BUILD_NUMBER']
                writeYaml file:"Chart.yaml", data: datas
                sh 'cd..'
                sh 'helm package java-helm'

                sh 'aws ecr get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin 804669271496.dkr.ecr.us-east-1.amazonaws.com'
                sh 'helm push java-helm-0.1.0.tgz oci://public.ecr.aws/x3x3m9h6/'
                sh 'aws ecr-public describe-images --repository-name java-helm --region us-east-1'
            }
        }
    }
}