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
                sh 'scp -r -i $(minikube ssh-key) ./*  docker@$(minikube ip):~/'
                sh "minikube ssh 'docker build -t smart-etech/grafana:${commit_id} .'"
                echo 'build complete'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes'
                sh "sed -i -r 's|smart-etech/grafana|smart-etech/grafana:${commit_id}|' grafana.yaml"
                sh 'kubectl get all -n grafana'
                sh 'kubectl apply -f grafana.yaml -n grafana'
                sh 'kubectl get all -n grafana'
                echo 'deployment complete'
                
            }
        }
    }
}