FROM ruby:2.3.0

ENV PHANTOMJS_VERSION 2.1.1
ENV PHANTOMJS_HOST https://s3-eu-west-1.amazonaws.com/calces-devstuff
ENV CACHED_DOWNLOAD="${HOME}/cache/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2"
ENV NVM_DIR /nvm

RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

RUN apt-get update && \
    apt-get install -y build-essential \
    postgresql-client libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf ~/.phantomjs
RUN mkdir ~/.phantomjs
RUN wget --continue --output-document "${CACHED_DOWNLOAD}" "${PHANTOMJS_HOST}/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2"
RUN tar -xaf "${CACHED_DOWNLOAD}" --strip-components=1 --directory "${HOME}/.phantomjs"

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 5.7.1 && nvm alias default 5.7.1

RUN source /root/.bashrc && npm install -g npm@3.8.0

RUN gem install bundler --pre
