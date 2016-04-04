FROM ruby:2.3.0

ENV NVM_DIR /nvm

RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

RUN apt-get update && \
    apt-get install -y build-essential \
    postgresql-client libssl-dev \
    qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    node-gyp g++ libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev \
    libkrb5-dev libgdbm-dev libc6-dev libbz2-dev python2.7-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar xj && \
    mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/ && rm -rf phantomjs-2.1.1-linux-x86_64

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 5.7.1 && nvm alias default 5.7.1 && \
    npm install -g npm@3.8.0 node-gyp

RUN gem install bundler --pre
