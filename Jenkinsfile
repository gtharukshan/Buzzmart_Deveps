pipeline {
    agent any

    environment {
        // --- CONFIGURATION REQUIRED ---
        // update these values or configure them in Jenkins Global Properties
        
        // Docker Hub Username
        DOCKER_HUB_USER = "${env.DOCKER_HUB_USER ?: 'tharukshan'}"
        
        // Docker Image Names
        DOCKER_HUB_REPO_BACKEND = "${env.DOCKER_HUB_REPO_BACKEND ?: 'mern-backend'}"
        DOCKER_HUB_REPO_FRONTEND = "${env.DOCKER_HUB_REPO_FRONTEND ?: 'mern-frontend'}"
        
        // Jenkins Credential IDs (Create these in Jenkins > Manage Jenkins > Credentials)
        // Type: Username with password
        DOCKER_CREDENTIALS_ID = "${env.DOCKER_CREDENTIALS_ID ?: 'docker-hub-credentials'}"
        
        // Type: SSH Username with private key
        SSH_CREDENTIALS_ID = "${env.SSH_CREDENTIALS_ID ?: 'ssh-private-key-id'}"
        
        // Ansible Configuration - REMOVED
        // ANSIBLE_INVENTORY = "${env.ANSIBLE_INVENTORY ?: 'ansible/inventory'}"
        
        // Server Configuration
        DEPLOY_SERVER_IP = "${env.DEPLOY_SERVER_IP ?: 'YOUR_SERVER_IP_HERE'}" // Set this in Jenkins Global Properties or here
        DEPLOY_SERVER_USER = "${env.DEPLOY_SERVER_USER ?: 'ubuntu'}"
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
                    echo "--- DEBUGGING INFO ---"
                    sh "whoami"
                    sh "ls -l /var/run/docker.sock"
                    // Check if we can talk to the socket raw
                    sh "curl --unix-socket /var/run/docker.sock http://localhost/_ping || echo 'Ping failed'"
                    sh "curl --unix-socket /var/run/docker.sock http://localhost/info || echo 'Info failed'"
                    echo "----------------------"
                    
                    echo "Building Backend Image..."
                    // explicit context setting just in case
                    sh "docker build -t ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_BACKEND}:latest ./backend"
                    
                    echo "Building Frontend Image..."
                    sh "docker build -t ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_FRONTEND}:latest ./frontend"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing images to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh "docker push ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_BACKEND}:latest"
                        sh "docker push ${DOCKER_HUB_USER}/${DOCKER_HUB_REPO_FRONTEND}:latest"
                        sh "docker logout"
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    echo "Deploying directly to server via SSH..."
                    
                    // We need to copy docker-compose.yml to the server and run it
                    sshagent (credentials: [SSH_CREDENTIALS_ID]) {
                        // 1. Create directory
                        sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER_USER}@${DEPLOY_SERVER_IP} 'mkdir -p /opt/buzzmart'"
                        
                        // 2. Copy docker-compose.yml
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yml ${DEPLOY_SERVER_USER}@${DEPLOY_SERVER_IP}:/opt/buzzmart/docker-compose.yml"
                        
                        // 3. Pull and Up
                        sh """
                            ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER_USER}@${DEPLOY_SERVER_IP} '
                                cd /opt/buzzmart && 
                                docker compose pull && 
                                docker compose up -d --remove-orphans
                            '
                        """
                    }
                }
            }
        }
    }
}
