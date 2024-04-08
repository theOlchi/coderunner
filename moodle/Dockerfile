FROM ubuntu:latest

# Install dependencies
RUN apt update -y && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends tzdata && \
    apt install -y apache2 mysql-client mysql-server php libapache2-mod-php vim graphviz aspell ghostscript clamav php-pspell php-curl php-gd php-intl php-mysql php-xml php-xmlrpc php-ldap php-zip php-soap php-mbstring git && \
    rm -rf /var/lib/apt/lists/*

# Clone Moodle repository
WORKDIR /opt
RUN git clone git://git.moodle.org/moodle.git && \
    cd moodle && \
    git branch --track MOODLE_401_STABLE origin/MOODLE_401_STABLE && \
    git checkout MOODLE_401_STABLE && \
    cp -R /opt/moodle /var/www/html/

# Create moodledata directory
RUN mkdir /var/www/moodledata && \
    chown -R www-data:www-data /var/www/moodledata && \
    chmod -R 0750 /var/www/moodledata

# Restart MySQL service and setup Moodle database
RUN service mysql restart && \
    DB_USER="admin" && \
    DB_PASS="admin" && \
    DB_NAME="moodle" && \
    SQL_QUERY="CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; \
    CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin'; \
    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, CREATE TEMPORARY TABLES, DROP, INDEX, ALTER ON $DB_NAME.* TO 'admin'@'localhost';" && \
    echo "$SQL_QUERY" | mysql -u root -p"admin"

# Configure PHP settings
RUN sed -i 's/^;max_input_vars = .*/max_input_vars = 5000/' /etc/php/8.1/apache2/php.ini && \
    sed -i 's/^;max_input_vars = .*/max_input_vars = 5000/' /etc/php/8.1/cli/php.ini

# Clone additional Moodle plugins
RUN git clone https://github.com/trampgeek/moodle-qtype_coderunner.git /var/www/html/moodle/question/type/coderunner && \
    git clone https://github.com/trampgeek/moodle-qbehaviour_adaptive_adapted_for_coderunner.git /var/www/html/moodle/question/behaviour/adaptive_adapted_for_coderunner

# Restart Apache and MYSQL service + Install moodle
RUN service apache2 restart && service mysql start && \
    sleep 10 && \
    php /var/www/html/moodle/admin/cli/install.php --wwwroot=http://localhost:8080/moodle --dataroot=/var/html/moodledata/ --dbtype=mysqli --dbhost=127.0.0.1 --dbname=moodle --dbuser=admin --dbpass=admin --fullname=MoodleDockerContainer --shortname=MCLI --adminpass=asdf --adminemail=user@example.com --non-interactive --agree-license

# Set permissions
RUN chmod 777 -R /var/www/html/moodle/

# Expose port 80
EXPOSE 80

# Restart Apache and MySQL services
CMD service mysql start && \
    apachectl -DFOREGROUND