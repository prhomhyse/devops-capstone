pipeline {
    environment {
    registry = "prhomhyse/devops-capstone"
    registryCredential = 'docker-hub'
    }
    
    agent any
    stages {
        
        stage ('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
                sh 'pylint --disable=R,C,W1203 app.py'
            }
        }

        stage ('Cloning Git') {
            steps {
                git 'https://github.com/prhomhyse/devops-capstone.git'
            }
        }

        stage('Building image') {
            steps {
                script {
                    sh 'docker build --tag=prhomhyse/capstone-devops-capstone .'
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker-hub", url: "" ]) {
                    sh 'docker push prhomhyse/devops-capstone'
                    }
                }
            }
        }

        stage ('Upload latest green deployment to AWS Loadbalancer') {
            steps {
               script {
                   // Latest
                   sh 'kubectl apply -f Deployment/green-webapp-deploy.yml'
               }
            }
        }

        stage ('Remove old blue deployment from AWS Loadbalancer') {
            steps {
               script {
                   sh 'kubectl delete deploy/web-deployment-blue'
               }
            }
        }

        stage ('Add latest blue deployment to AWS Loadbalancer') {
            steps {
               script {
                   sh 'kubectl apply -f Deployment/blue-webapp-deploy.yml'
               }
            }
        }

        stage ('Remove old green deployment from AWS Loadbalancer') {
            steps {
               script {
                   sh 'kubectl delete deploy/web-deployment-green'
               }
            }
        }
    }
}