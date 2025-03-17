################################################################################
# Base Stage
################################################################################
FROM ruby:3.4.2-slim-bookworm AS base

EXPOSE 8080

# Configure application environment.
ENV RACK_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_WITHOUT="development:test"

WORKDIR /usr/src/app

# Install system dependencies.
RUN apt update && \
    apt install --no-install-recommends --yes \
      libjemalloc2 \
      libyaml-dev \
      && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

################################################################################
# Build Stage
################################################################################
FROM base AS build

# Install system dependencies.
RUN apt update && \
    apt install --no-install-recommends --yes \
      g++ \
      make \
      && \
    rm -rf /var/lib/apt/lists/*

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf vendor/bundle/ruby/3.3.0/cache/*.gem \
    && find vendor/bundle/ruby/3.3.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

COPY . .

RUN bundle exec rake assets:precompile

################################################################################
# Production Stage
################################################################################
FROM base AS production

COPY --from=build "${WORKDIR}" "${WORKDIR}"

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bundle", "exec", "puma"]
