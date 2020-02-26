pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'docker build --no-cache -t docker-registry:5001/ripple_server .'
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing..'
                sh 'docker push docker-registry:5001/ripple_server'
            }
        }
        stage('Deploying') {
            steps {
                    sshagent (credentials: ['jenkins_webserver_login']) 
                        {
                            sh 'ssh -o StrictHostKeyChecking=no -l jenkinscd 10.10.70.12 ./k8s_deployment/deploy-in-k8s.sh'
                        } 
            }
        }
    }
}