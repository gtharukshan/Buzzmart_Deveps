pipeline {
    agent any

    environment {
        // Define these in Jenkins Credentials/Environment or override here
        DOCKER_HUB_USER = "${env.DOCKER_HUB_USER ?: 'tharukshan'}"
        DOCKER_HUB_REPO_BACKEND = "${env.DOCKER_HUB_REPO_BACKEND ?: 'mern-backend'}"
        DOCKER_HUB_REPO_FRONTEND = "${env.DOCKER_HUB_REPO_FRONTEND ?: 'mern-frontend'}"
        // Credential ID stored in Jenkins
        DOCKER_CREDENTIALS_ID = "${env.DOCKER_CREDENTIALS_ID ?: 'docker-hub-credentials'}"
        ANSIBLE_INVENTORY = "${env.ANSIBLE_INVENTORY ?: 'ansible/inventory'}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_BACKEND}:latest ./backend"
                    sh "docker build -t ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_FRONTEND}:latest ./frontend"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_BACKEND}:latest"
                        sh "docker push ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_FRONTEND}:latest"
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    // Ensure ansible is installed and inventory is correct
                    // You might need to set up SSH keys in Jenkins credential store and use sshagent
                    sshagent (credentials: ['ssh-private-key-id']) { 
                        sh "ansible-playbook -i ${ANSIBLE_INVENTORY} ansible/playbook.yml"
                    }
                }
            }
        }
    }
}
