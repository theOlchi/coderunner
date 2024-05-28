FROM ubuntu:latest

# Install dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y apache2 mysql-client mysql-server php8.1 libapache2-mod-php8.1 vim graphviz aspell ghostscript clamav php8.1-pspell php8.1-curl php8.1-gd php8.1-intl php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-ldap php8.1-zip php8.1-soap php8.1-mbstring git && \
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