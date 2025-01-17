# iCAD Dispatch Docker Deploy

iCAD Dispatch is a Progressive Web Application (PWA) that processes audio inputs, analyzes them, and sends alerts based on the processed data. It includes a database and other essential deployment files for seamless operation.

---

## Requirements
- **Linux**: This software is mean to be run on a Linux Server of some sort. I developed it running on a debian based distro.
- **Docker**: Ensure Docker is installed on your system. [Install Docker](https://docs.docker.com/get-docker/)
- **Git**: Required to clone the repository. [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

---

## Deployment Guide

Follow these steps to deploy the application from scratch:

### 1. **Create a Non-root User**
For security and compatibility with the Docker image, create a non-root user on your host system. The user will not have login access to the host.

Run the following commands:
```bash
# Create a group with GID 9911
sudo groupadd -g 9911 icad_dispatch

# Create a user with UID 9911, assign to the group, and disable login
sudo useradd -M -s /usr/sbin/nologin -u 9911 -g icad_dispatch icad_dispatch
```

**Explanation**:
- **`-M`**: Prevents creating a home directory for the user (the user won't own files outside the application scope).
- **`-s /usr/sbin/nologin`**: Sets the shell to `/usr/sbin/nologin`, disabling the user from logging into the system interactively.

---

### 2. **Grant Group Access to Your User**
To allow your regular user to manage files owned by the `icad_dispatch` group (e.g., for logs and configuration files), add your user to the `icad_dispatch` group.

Run the following command:
```bash
# Add your user to the icad_dispatch group
sudo usermod -aG icad_dispatch your_user
```

**Explanation**:
- **`usermod`**: Modifies the properties of an existing user.
- **`-aG`**: Appends the user to the specified group without removing them from existing groups.
- Replace `your_user` with your current username.

After running this command, you may need to log out and log back in for the changes to take effect. Once added to the group, your user will have read and write access to files owned by `icad_dispatch`.

---

### 3. **Clone the Repository**
Choose a directory where you want to deploy the application and clone this repository:
```bash
git clone https://github.com/TheGreatCodeholio/icad_dispatch_docker.git
cd icad-dispatch
```

---

### 4. **Set Up the Directory Structure**
Ensure the directory has the required structure for the application to function correctly. The `.env` file specifies the working path for mounting volumes.

#### Create and Adjust Permissions for Directories:
Run the following commands:
```bash
# Create the required directories
mkdir -p log etc

# Change ownership to the non-root user
sudo chown -R icad_dispatch:icad_dispatch log etc
```

The `log` directory will store logs, and the `etc` directory will store configuration files.

---

### 5. **Configure the `.env` File**
Update the `.env` file with your specific configuration values. Key variables to update:
- **`WORKING_PATH`**: Set this to the absolute path of the cloned repository.
- **Database and Redis Credentials**: Set secure passwords and connection details.
  
Example `.env`:
```dotenv
# Log Level
LOG_LEVEL=1

# Working Path
WORKING_PATH="/home/icad_dispatch/icad-dispatch"

# URL
BASE_URL=https://example.com

# MySQL Configuration
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_USER=your_user
MYSQL_PASSWORD='your_password'
MYSQL_ROOT_PASSWORD='your_root_password'
MYSQL_DATABASE=icad_db

# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD='your_redis_password'
REDIS_CACHE_DB=0
REDIS_MYSQL_CACHE_DB=3
REDIS_SESSION_DB=4
```

---

### 6. **Run Docker Compose**
With the environment configured and directories prepared, you can start the application using Docker Compose.

Run the following command:
```bash
docker compose up -d
```

This command will:
1. Pull the necessary images from the repository.
2. Build and start the containers in detached mode (running in the background).
3. Mount the `log` and `etc` directories based on the `WORKING_PATH` specified in the `.env` file.

---

### 7. **Verify Deployment**

#### Check if Containers Are Running
To list all running containers, use:
```bash
docker ps -a
```

- This command will display a table of running containers, including their **container IDs**, names, and status.
   
#### Check Container Logs
1. Identify the container name or ID from the output of `docker ps`.
2. View live logs for a specific container:
 ^^bash
 docker logs -f <container_id_or_name>
 ^^
 - Replace `<container_id_or_name>` with the actual container ID or name (e.g., `flask-app`).

#### Example
To view logs for the Flask application:
```bash
docker logs -f flask-app
```

This will show real-time logs to help you verify that the services are starting as expected.

---

## Security Best Practices
1. **Run as Non-root**: The application enforces a non-root user within the container to improve security. Host directories and files in the working path must be read/write by the same non-root user (`icad_dispatch`).

2. **Use Secure Passwords**: Update the `.env` file with strong, unique passwords for MySQL and Redis.

3. **Restrict Permissions**: Allow only the `icad_dispatch` group and `your_user` access to the application directory and logs:
   ```bash
   sudo chown your_user:icad_dispatch /home/your_user/icad_dispatch_docker
   sudo chmod -R 760 /home/your_user/icad_dispatch_docker
   ```
4. **Use HTTPS**: Ensure the application is accessed via HTTPS in production to secure data in transit.

---

