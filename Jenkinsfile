pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-angular-app'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/casimirrex/productapi_backend.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run('-p 4200:80')
                }
            }
        }

        stage('Wait for Container') {
            steps {
                script {
                    sleep 30 // Wait for the container to be fully up and running
                }
            }
        }

        stage('Validate Page') {
            steps {
                script {
                    def responseCode = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:4200/product-form', returnStdout: true).trim()
                    if (responseCode != '200') {
                        error "Failed to access /product-form page. HTTP status code: ${responseCode}"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                def dockerIds = sh(script: "docker ps -a -q --filter ancestor=${DOCKER_IMAGE}", returnStdout: true).trim()
                if (dockerIds) {
                    sh "docker stop ${dockerIds}"
                    sh "docker rm ${dockerIds}"
                }
            }
        }
    }
}
