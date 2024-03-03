FROM ruby:3.3.0-slim-bookworm

EXPOSE 8080

# Configure application environment.
ENV RACK_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

WORKDIR /usr/src/app

# Install system dependencies.
RUN apt update && \
    apt install --no-install-recommends --yes \
      g++ \
      libjemalloc2 \
      make \
      && \
    rm -rf /var/lib/apt/lists/*

# Configure memory allocation.
ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libjemalloc.so.2"

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf vendor/bundle/ruby/3.3.0/cache/*.gem \
    && find vendor/bundle/ruby/3.3.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

COPY . .

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
