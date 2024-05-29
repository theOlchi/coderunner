# Use the latest jobe image as the base image
FROM trampgeek/jobeinabox:latest

# Copy additional intialization scripts to the image
COPY src /src

# Update the PATH environment variable
ENV COMPOSER_HOME="/usr/local/.composer"
ENV NODE_PATH="/usr/local/lib/node_modules"
ENV PATH="${PATH}:/usr/local/.composer/vendor/bin:/usr/local/lib/node_modules"

# Install additional packages and set up the environment
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends npm \
                                                  wget \
    && mkdir /home/jobe00 \
    && chmod a+rwx /home/jobe00 \
    && cd /src \
    && chmod 755 *.sh \
    && /src/install-php-tools.sh \
    && /src/install-php-packages.sh \
    && /src/install-node-packages.sh \
    && /src/install-python-packages.sh \
    && rm -rf /var/lib/apt/lists/*