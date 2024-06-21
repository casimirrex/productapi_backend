pipeline {
    agent any

    environment {
        BACKEND_DOCKER_IMAGE = 'casimirrex/productapi_backend'
        BACKEND_PORT = '8081'
        ACTUATOR_USERNAME = 'user' // default Spring Boot username
        ACTUATOR_PASSWORD = 'generated-security-password' // replace with the actual password
    }

    stages {
        stage('Clone Backend Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/casimirrex/productapi_backend.git'
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean package'
                }
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
                    backendDockerImage.run("-d -p ${BACKEND_PORT}:${BACKEND_PORT}")
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

        stage('Validate Backend API') {
            steps {
                script {
                    def responseCode = sh(script: "curl -o /dev/null -s -w '%{http_code}' -u ${ACTUATOR_USERNAME}:${ACTUATOR_PASSWORD} http://localhost:${BACKEND_PORT}/actuator/health", returnStdout: true).trim()
                    if (responseCode != '200') {
                        error "Failed to access backend API. HTTP status code: ${responseCode}"
                    }
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
