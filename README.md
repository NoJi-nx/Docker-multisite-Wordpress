# Docker-multi-wordpress-www

## Project Overview
This project aims to develop and manage multiple WordPress sites using Docker containers. By using Docker, each WordPress instance can be isolated, making scaling, management, and migration to cloud platforms easier. The project also includes implementing backup and restore mechanisms to ensure data security and continuity.

## Prerequisites
Before starting, make sure you have the following installed:

* Docker
*  Docker Compose
* AWS CLI (for cloud migration)

## Project Structure

```
docker-multi-wordpress-www/
├── docker-compose.yml
├── site1/
│   ├── wp-admin/
│   ├── wp-content/
│   │   ├── plugins/
│   │   ├── themes/
│   │   └── uploads/
│   ├── index.php
│   └── wp-includes/
└── site2/
    ├── wp-admin/
    ├── wp-content/
    │   ├── plugins/
    │   ├── themes/
    │   └── uploads/
    ├── index.php
    └── wp-includes/
```

## Installation and Setup

### 1.  Clone the Project

```bash
git clone 
https://github.com/yourusername/docker-multi-wordpress-www.git
cd docker-multi-wordpress-www
```

### 2. Create and Run Docker Containers
```
docker-compose up -d
```



### 3. Structure the Directories <br>
For each WordPress site, navigate to the respective directory (site1 or site2) and edit the content as needed. You can customize themes and plugins by editing files such as functions.php, style.css, header.php, and footer.php.

### 4. Implement Backup and Restore <br>
To back up and restore your WordPress sites, use the UpdraftPlus plugin.

**Restoring from Backup**:

1. Prepare the Docker Environment:

```
docker-compose up -d
```


2. Extract Backup Files:

```bash
mkdir -p my-wordpress-backup
mv backup_file.gz my-wordpress-backup/
cd my-wordpress-backup
gunzip backup_file.gz
```

3. Import the Database:
```
docker cp backup.sql db2:/backup.sql
docker exec -i db2 mysql -u root -pYourPassword exampledb2 < /backup.sql
```
5. Set Up WordPress Files:
```bash
tar -xzvf backup-plugins.tar.gz -C ./site2/wp-content/plugins/
tar -xzvf backup-themes.tar.gz -C ./site2/wp-content/themes/
tar -xzvf backup-uploads.tar.gz -C ./site2/wp-content/uploads/
sudo chown -R $USER:www-data site2
sudo chmod -R 755 site2
```

1. Verify and Update Configuration:
   
   <br>Update `wp-config.php`:

```php
define('DB_NAME', 'exampledb2');
define('DB_USER', 'exampleuser');
define('DB_PASSWORD', 'examplepass');
define('DB_HOST', 'db2');
```

Restart Docker Containers:

```bash
docker-compose down
docker-compose up -d
```

1. Update Permalinks:

Log in to the WordPress admin dashboard to update permalinks:

```
http://localhost:8082/wp-admin
```

## Migration to Cloud Platforms
To migrate Docker containers to cloud platforms like AWS, Google Cloud, or Azure, follow these steps:

### 1. Push Docker Images to a Container Registry

For AWS ECR:
1. Create ECR Repository:
```
aws ecr create-repository --repository-name wordpress1
aws ecr create-repository --repository-name wordpress2
```

2. Authenticate Docker to ECR:

```
aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<region>.amazonaws.com
```

3. Tag and Push Docker Images:

```
docker tag wordpress1:latest <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wordpress1:latest
docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wordpress1:latest

docker tag wordpress2:latest <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wordpress2:latest
docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wordpress2:latest
```

### 2.  Deploy to Cloud Platform

For AWS ECS:
1. Create ECS Task Definitions in AWS Management Console.
2. Create an ECS Cluster and Service and link them to the ECS cluster.

## Preparing for AWS CLI
Install AWS CLI:

For Windows: <br>
Download and install from the official AWS CLI page.

For macOS: <br>
Install via Homebrew:
```
brew install awscli
```

**For Linux:** <br>
Install using package manager:

```
sudo apt-get update
sudo apt-get install awscli -y
```
Alternatively, install manually:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Configure AWS CLI with your credentials:

1. Create an IAM user with necessary permissions.

2. Configure AWS CLI on your local machine:

``` 
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, region, and output format (json).

By following these steps, you can successfully migrate WordPress sites to cloud platforms and take advantage of their scalability and flexibility.

## Summary
This project provides a comprehensive guide for setting up, managing, and migrating WordPress sites using Docker. By following the steps above, you can ensure that your WordPress sites are scalable, secure, and easy to manage.


