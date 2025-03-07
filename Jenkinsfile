pipeline {
    agent any
    environment {
        // DOCKER_HUB_CREDENTIALS = credentials('docker-hub-token')  // Reference the credential ID
        KUBECONFIG = credentials('kubeconfig') 
    }
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Mahananda-Kawale/node-js-sample.git',
                    branch: 'main'
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
                    sh "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${dockerRegistry}"

                    // Build Docker image
                    sh "docker build -t ${dockerUsername}/${dockerImageName}:${dockerImageTag} ."

                    // // Push Docker image to the registry
                    sh "docker push ${dockerUsername}/${dockerImageName}:${dockerImageTag}"
                    
                    }
                }
            }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/network-policy.yaml'
                sh 'kubectl apply -f k8s/peristent-volume.yaml'
            }
        }

         // Stage 4: Clean Workspace
        // stage('Clean Workspace') {
        //     steps {
        //         cleanWs()  // Safely clean the workspace
        //     }
        // }
    }

    // Post-build actions
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
