##################################################
# Build Stage
##################################################
FROM ruby:2.6.6-slim-stretch as Build

ENV RACK_ENV production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        g++ \
        git \
        make \
        nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && gem update --system \
    && gem install bundler \
    && bundle config --global frozen true \
    && bundle config --global no-cache 'true' \
    && bundle config --global without 'development test'

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . .

RUN bundle exec rake assets:precompile

##################################################
# Final Stage
##################################################
FROM ruby:2.6.6-slim-stretch

ENV RACK_ENV production
ENV EXECJS_RUNTIME Disabled

COPY --from=Build /usr/local/bundle /usr/local/bundle
COPY --from=Build /usr/src/app /usr/src/app

WORKDIR /usr/src/app

CMD ["bundle", "exec", "rackup", "--port", "8080"]
