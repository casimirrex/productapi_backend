pipeline {
    agent any

    environment {
        BACKEND_DOCKER_IMAGE = 'casimirrex/productapi_backend'
        BACKEND_PORT = '8081'
    }

    stages {
        stage('Clone Backend Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/casimirrex/productapi_backend.git', credentialsId: 'docker-credentials'
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                }
            }
        }

        stage('Build Backend Docker Image') {
            steps {
                script {
                    retry(3) {
                        backendDockerImage = docker.build("${BACKEND_DOCKER_IMAGE}")
                    }
                }
            }
        }

        stage('Run Backend Docker Container') {
            steps {
                script {
                    backendDockerImage.run("-d -p ${BACKEND_PORT}:8080") // Assuming your backend service runs on port 8080 inside the container
                }
            }
        }

        stage('Wait for Backend Container') {
            steps {
                script {
                    sleep 120 // Wait for 2 minutes
                }
            }
        }
    }
}
