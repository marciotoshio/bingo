FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev default-jre

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle \
  GEM_PATH=/bundle \
  GEM_HOME=/bundle

RUN bundle install

COPY . $APP_HOME
