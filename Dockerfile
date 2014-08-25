FROM centurylink/apache-php:latest
MAINTAINER CentruyLink

# Install packages
RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor pwgen && \
 apt-get -y install mysql-client unzip

# Download CodeIgniter into /app
RUN rm -fr /app && mkdir /app && \
 curl -O https://ellislab.com/codeigniter/download && \
 unzip CodeIgniter_2.2.0.zip -d /app  && \
 rm CodeIgniter_2.2.0.zip

# Add configuration with info for Joomla to connect to DB
ADD database.php /app/application/config/database.php
RUN chmod 644 /app/application/config/database.php

# Fix permissions for apache
RUN chown -R www-data:www-data /app

EXPOSE 80
CMD ["/run.sh"]