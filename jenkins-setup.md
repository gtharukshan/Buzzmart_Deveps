# Jenkins Setup for Docker Access

Since the Jenkins pipeline needs to build Docker images, the Jenkins container must have access to the host's Docker daemon.

## 1. Stop Existing Jenkins
If you have an existing Jenkins container running, stop and remove it:
```bash
docker stop jenkins
docker rm jenkins
```

## 2. Start Jenkins with Docker Access
Run the following command in this directory:
```bash
docker compose -f jenkins-compose.yml up -d --build
```

## 3. Verify Access
1. Check logs: `docker logs -f jenkins`
2. Get the initial admin password:
   ```bash
   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. Open `http://localhost:8080` and unlock Jenkins.
4. Install recommended plugins.
5. Create an admin user.

## 4. Verify Docker in Jenkins
You can verify Docker access by running this command inside the container:
```bash
docker exec -it jenkins docker ps
```
If this lists your containers, Jenkins has access to Docker!
