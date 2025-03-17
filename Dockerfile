################################################################################
# Base Stage
################################################################################
FROM ruby:3.4.2-slim-bookworm AS base

EXPOSE 8080

WORKDIR /usr/src/app

# Configure application environment.
ENV RACK_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="${WORKDIR}/vendor/bundle" \
    BUNDLE_WITHOUT="development:test"

# Install system dependencies.
RUN apt update -qq && \
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
RUN apt update -qq && \
    apt install --no-install-recommends --yes \
      g++ \
      make \
      && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git \
    && find "${BUNDLE_PATH}"/ruby/*/gems/ \( -name "*.c" -o -name "*.o" \) -delete

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
