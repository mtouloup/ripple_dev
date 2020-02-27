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
                    sshagent (credentials: ['k8s-master-ssh']) 
                        {
							sh 'ssh -o StrictHostKeyChecking=no -l jenkinsci 10.10.70.12 git clone https://github.com/mtouloup/ripple_dev.git'
                            sh 'ssh -o StrictHostKeyChecking=no -l jenkinsci 10.10.70.12 kubectl apply -f ripple_dev/k8s_deployment/services/ripple_serv.yml'
							sh 'ssh -o StrictHostKeyChecking=no -l jenkinsci 10.10.70.12 kubectl apply -f ripple_dev/k8s_deployment/deployments/ripple_depl.yml'
                            sh 'ssh -o StrictHostKeyChecking=no -l jenkinsci 10.10.70.12 cd ../../'
							sh 'ssh -o StrictHostKeyChecking=no -l jenkinsci 10.10.70.12 rm -rf ripple_dev'
                        } 
            }
        }
    }
}