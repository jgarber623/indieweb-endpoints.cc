################################################################################
# Base Stage
################################################################################
FROM ruby:3.1.2-alpine3.15 AS base-stage

ARG BUNDLER_VERSION="2.3.11"

ENV BUNDLE_JOBS=10 \
    BUNDLE_RETRIES=5

EXPOSE 8080

RUN echo "gem: --no-document" >> ~/.gemrc && \
    gem install bundler --version "${BUNDLER_VERSION}"

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

################################################################################
# Development
################################################################################
FROM base-stage AS development

ENV RACK_ENV=development

RUN apk add --no-cache --update g++ git make

RUN bundle install
