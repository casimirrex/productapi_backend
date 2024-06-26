pipeline {
    agent any

    environment {
        BACKEND_DOCKER_IMAGE = 'casimirrex/productapi_backend'
        BACKEND_PORT = '8081'
        DOCKER_USERNAME = 'casimirrex@gmail.com'
        DOCKER_PASSWORD = 'Antonyba28$'
    }

    stages {
        stage('Clone Backend Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/casimirrex/productapi_backend.git', credentialsId: 'springboot-user'
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
                script {
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
                    sleep 60 // Wait for the container to be fully up and running
                }
            }
        }

        stage('Post Data to Backend') {
            steps {
                script {
                    sh """
                    curl -X POST -H "Origin: http://localhost:4200" -H "Content-Type: application/json" --verbose -d '{"name":"Product 1","description":"First product","price":10.99}' http://localhost:${BACKEND_PORT}/products
                    """
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
