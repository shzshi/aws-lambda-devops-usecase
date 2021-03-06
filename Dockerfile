FROM jenkins/jenkins:lts
USER root

# Install Node.js
RUN apt-get update -y
RUN apt-get install -y apt-utils
RUN apt-get install -y sudo
RUN apt-get install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install --yes nodejs
RUN apt-get install --yes build-essential
RUN npm i -g npm

RUN npm install serverless -g
RUN npm install serverless-dynamodb-local --save-dev
RUN npm install serverless-offline --save-dev
RUN npm install --save-dev serverless-mocha-plugin
RUN serverless dynamodb install

RUN npm config set prefix '~/.npm-global'
RUN export PATH=~/.npm-global/bin:$PATH

USER jenkins
