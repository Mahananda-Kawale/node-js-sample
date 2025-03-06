pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-token')  // Reference the credential ID
        KUBECONFIG = credentials('kubeconfig') 
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
                   // Hardcoded credentials (NOT RECOMMENDED)
                    def dockerRegistry = "https://index.docker.io/v1/"
                    def dockerUsername = "srikantb1"
                    def dockerPassword = "dckr_pat_FIsZePNH1DzR2lvWQCJmmWzEB3I"
                    //def dockerPassword = '${DOCKER_HUB_CREDENTIALS}'
                    def dockerImageName = "node-js-sample"
                    def dockerImageTag = "1.0"

                    // Log in to Docker registry
                    bat "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${dockerRegistry}"

                    // Build Docker image
                    bat "docker build -t ${dockerUsername}/${dockerImageName}:${dockerImageTag} ."

                    // // Push Docker image to the registry
                    bat "docker push ${dockerUsername}/${dockerImageName}:${dockerImageTag}"
                    
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
