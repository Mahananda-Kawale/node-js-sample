pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-token')  // Reference the credential ID
    }
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Mahananda-Kawale/node-js-sample.git',
                    branch: 'Mahananda-Kawale-patch-1'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    bat 'docker build -t node-js-sample:1.0 .'
                    echo '${DOCKER_HUB_CREDENTIALS}' | bat 'docker login --username srikantb1 --password-stdin'
                   
                    bat 'docker tag node-js-sample:1.0 srikantb1/node-js-sample:1.0'
                    bat 'docker push srikantb1/node-js-sample:1.0'
                    
                    }
                }
            }
        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s/deployment.yaml'
                // bat 'kubectl apply -f k8s/network-policy.yaml'
                // bat 'kubectl apply -f k8s/peristent-volume.yaml'
            }
        }

        stage('Clean Workspace') {
            steps {
                bat 'rm -rf *' // Clean the workspace
            }
        }
    }
}
