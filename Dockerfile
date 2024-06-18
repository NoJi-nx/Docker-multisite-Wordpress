# Use the official WordPress image from the Docker Hub
FROM wordpress:latest

# Set the environment variables for WordPress
ENV WORDPRESS_DB_HOST=db
ENV WORDPRESS_DB_USER=exampleuser
ENV WORDPRESS_DB_PASSWORD=examplepass
ENV WORDPRESS_DB_NAME=exampledb

# Copy any custom plugins or themes (if you have any)
# COPY ./path/to/custom/plugins /var/www/html/wp-content/plugins/
# COPY ./path/to/custom/themes /var/www/html/wp-content/themes/

# Expose port 80 for the web server
EXPOSE 80