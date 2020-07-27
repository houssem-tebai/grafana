def commit_id
pipeline {
    agent any
    

    stages {
        stage('Preparation') {
            steps {
                checkout scm
                sh "git rev-parse --short HEAD > .git/commit-id"
                script {                        
                    commit_id = readFile('.git/commit-id').trim()
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building....'
                sh 'scp -i $(minikube ssh-key) ./Dockerfile  docker@$(minikube ip):~/'
                sh 'minikube ssh'
                sh 'whoami'
                sh "docker build -t smart-etech/grafana:${commit_id} ."
                echo 'build complete'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes'
                sh ''
                sh 'kubectl get all -n grafana'
                
            }
        }
    }
}