FROM amazonlinux:latest
MAINTAINER  Marcio Rabelo <marcio@modular.network>

# Env vars
ENV NODE_VERSION 6.10.0

# Build
RUN mkdir -p /app
RUN yum update -y
RUN yum install curl gcc gcc-c++ make openssl-devel cmake -y

# Download Nodejs
RUN mkdir -p /tmp && cd /tmp
RUN curl -O https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz
RUN tar -zxvf node-v$NODE_VERSION.tar.gz && rm node-v$NODE_VERSION.tar.gz

# Install Nodejs
RUN cd node-v$NODE_VERSION && ./configure && make
RUN cd node-v$NODE_VERSION && make install

WORKDIR "/app"
VOLUME "/app"

# Install serverless and add application to the container
RUN npm install -g serverless && \
    npm set progress=false

ADD ./app .