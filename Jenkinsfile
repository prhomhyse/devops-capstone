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
                    sh 'docker build --tag=prhomhyse/devops-capstone .'
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
                    withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                   // Latest
                   sh "aws eks --region us-west-2 update-kubeconfig --name zetacluster"
                   sh 'kubectl apply -f deploy/green.yml'
                  }
               }
            }
        }

        stage ('Remove old blue deployment from AWS Loadbalancer') {
            steps {
               script {
                withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                   sh 'kubectl delete deploy/blue-deployment'
               }
               }
            }
        }

        stage ('Add latest blue deployment to AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                   sh 'kubectl apply -f deploy/blue.yml'
                   }
               }
            }
        }

        stage ('Remove old green deployment from AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                   sh 'kubectl delete deploy/green-deployment'
                   }
               }
            }
        }
    }
}