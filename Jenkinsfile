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
        stage('Code Quality') {
            steps {
                withSonarQubeEnv('code-quality'){
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage("Quality Gate") {
            steps {
                script {
                    def qg = waitForQualityGate(webhookSecretId: '1f3843bb74f924ca00b0317e97eb737e9f92e7f4')
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
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
        stage('push to nexus') {
            steps {
                echo 'Pushing to nexus private repo....'
                sh "sudo docker build -t localhost:8090/grafana:${commit_id} ."
                sh "sudo docker push localhost:8090/grafana:${commit_id}"
                echo 'image pushed to nexus'
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