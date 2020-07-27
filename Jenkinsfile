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
                sh "docker build -t smart-etech/grafana:${commit_id} ."
                echo 'build complete'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes'
                sh 'kubectl get all -n grafana'
                
            }
        }
    }
}