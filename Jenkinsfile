pipeline {
    agent any

    environment {
        BACKEND_DOCKER_IMAGE = 'your-dockerhub-username/your-spring-boot-app'
    }

    stages {
        stage('Clone Backend Repository') {
            steps {
                git 'https://github.com/casimirrex/productapi_backend.git'
            }
        }

        stage('Build Backend Docker Image') {
            steps {
                script {
                    backendDockerImage = docker.build(BACKEND_DOCKER_IMAGE)
                }
            }
        }

        stage('Run Backend Docker Container') {
            steps {
                script {
                    backendDockerImage.run('-p 8081:8081')
                }
            }
        }

        stage('Wait for Backend Container') {
            steps {
                script {
                    sleep 60 // Wait for the container to be fully up and running
                }
            }
        }
    }

    post {
        always {
            script {
                def backendDockerIds = sh(script: "docker ps -a -q --filter ancestor=${BACKEND_DOCKER_IMAGE}", returnStdout: true).trim()
                if (backendDockerIds) {
                    sh "docker stop ${backendDockerIds}"
                    sh "docker rm ${backendDockerIds}"
                }
            }
        }
    }
}
