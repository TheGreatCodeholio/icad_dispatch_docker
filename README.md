# iCAD Dispatch Docker Deploy

## Requirements
- Docker

## Usage
1. Edit the `.env` file to configure the environment variables for your setup.
2. Run Docker Compose to deploy the application:
   ```bash
   docker-compose up -d
   ```

# Configuration Guide for `.env` File in Docker Compose

This guide helps you configure the `.env` file for your Docker Compose setup. Follow the instructions below to customize the environment variables according to your requirements.

---

## Environment Variables

### **Log Level**
Controls the verbosity of application logs:
- **1**: Debug (most detailed logging)
- **2**: Info
- **3**: Warning
- **4**: Error
- **5**: Critical (least detailed logging)

Example:
```dotenv
LOG_LEVEL=1
```

---

### **Working Path**
Specifies the base directory on the host machine to mount volumes for logs and configuration files.

Example:
```dotenv
WORKING_PATH="/path/to/your/working/directory"
```

Ensure the path exists on your host machine, as it will be mounted to:
- `/app/log` for logs
- `/app/etc` for configuration files.

---

### **URL**
Set the base URL for the application.

Example:
```dotenv
BASE_URL=https://example.com
```

---

### **Session Cookies**
Configure session cookie behavior:
- **SESSION_COOKIE_SECURE**: Set to `True` to secure cookies for HTTPS connections.
- **SESSION_COOKIE_DOMAIN**: The domain for which the session cookie is valid.
- **SESSION_COOKIE_NAME**: The name of the session cookie.
- **SESSION_COOKIE_PATH**: The path for which the cookie is valid (default is `/`).

Example:
```dotenv
SESSION_COOKIE_SECURE=True
SESSION_COOKIE_DOMAIN=example.com
SESSION_COOKIE_NAME=app_session
SESSION_COOKIE_PATH=/
```

---

### **MySQL Configuration**
Set up MySQL credentials and connection details:
- **MYSQL_HOST**: Hostname or IP of the MySQL server (default: `mysql`).
- **MYSQL_PORT**: MySQL port (default: `3306`).
- **MYSQL_USER**: Username for the MySQL database.
- **MYSQL_PASSWORD**: Password for the MySQL user.
- **MYSQL_ROOT_PASSWORD**: Password for the MySQL root user.
- **MYSQL_DATABASE**: Name of the database to use.

Example:
```dotenv
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_USER=my_user
MYSQL_PASSWORD='my_password'
MYSQL_ROOT_PASSWORD='root_password'
MYSQL_DATABASE=my_database
```

---

### **Redis Configuration**
Set up Redis connection and database usage:
- **REDIS_HOST**: Hostname or IP of the Redis server (default: `redis`).
- **REDIS_PORT**: Redis port (default: `6379`).
- **REDIS_PASSWORD**: Password for Redis (if authentication is enabled).
- **REDIS_CACHE_DB**: Database number for general caching (default: `0`).
- **REDIS_MYSQL_CACHE_DB**: Database number for MySQL-specific caching (default: `3`).
- **REDIS_SESSION_DB**: Database number for session storage (default: `4`).

Example:
```dotenv
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD='redis_password'
REDIS_CACHE_DB=0
REDIS_MYSQL_CACHE_DB=3
REDIS_SESSION_DB=4
```

---

### **Mounting Volumes**
The `WORKING_PATH` is used to mount volumes for logs and configuration. Update your `docker-compose.yml` file to reference this path:

```yaml
volumes:
  - ${WORKING_PATH}/log:/app/log
  - ${WORKING_PATH}/etc:/app/etc
```

Ensure that the specified directories (`log` and `etc`) exist under the `WORKING_PATH` on your host system.

---

### Example `.env` File
```dotenv
# Log Level
LOG_LEVEL=1

# Working Path
WORKING_PATH="/path/to/your/working/directory"

# URL
BASE_URL=https://example.com

# Cookie Configuration
SESSION_COOKIE_SECURE=True
SESSION_COOKIE_DOMAIN=example.com
SESSION_COOKIE_NAME=app_session
SESSION_COOKIE_PATH=/

# MySQL Configuration
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_USER=my_user
MYSQL_PASSWORD='my_password'
MYSQL_ROOT_PASSWORD='root_password'
MYSQL_DATABASE=my_database

# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD='redis_password'
REDIS_CACHE_DB=0
REDIS_MYSQL_CACHE_DB=3
REDIS_SESSION_DB=4
```

---

## Notes
1. Make sure the `.env` file is in the same directory as your `docker-compose.yml`.
2. Do not commit the `.env` file to version control if it contains sensitive information like passwords. Use a `.gitignore` file to exclude it.
3. Ensure the directories specified in `WORKING_PATH` exist and have the appropriate permissions for Docker to access.

By following this guide, you can configure your `.env` file effectively to meet the requirements of your Docker Compose setup.
