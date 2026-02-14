# Fix Docker Desktop Socket Access

The previous attempt failed because Docker Desktop restricts direct file mounts of its internal socket, and directory mounts have connectivity issues.

The **correct fix** is to enable the system-level Docker socket in Docker Desktop settings. This allows `/var/run/docker.sock` to be used normally, just like on a standard Linux Docker installation.

## 1. Enable Default Docker Socket
1. Open **Docker Desktop Dashboard**.
2. Go to **Settings** (gear icon).
3. Navigate to **Advanced** (or **System** depending on version).
4. Check the box **"Allow the default Docker socket to be used (requires password)"**.
   - You may be prompted for your system password.
5. Click **Apply & Restart**.

## 2. Verify the Socket
After Docker Desktop restarts, run this in your terminal:
```bash
ls -l /var/run/docker.sock
```
It should now show the socket file (no "No such file" error).

## 3. Restart Jenkins
Now that the standard socket exists, restarting Jenkins with the standard configuration will work:

```bash
docker compose -f jenkins-compose.yml up -d --build --force-recreate
```

## 4. Verify in Jenkins
Trigger the pipeline again. It should now succeed!
