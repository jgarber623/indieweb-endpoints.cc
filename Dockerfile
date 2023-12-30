FROM ruby:3.2.2-alpine3.19

EXPOSE 8080

# Silence Ruby deprecation warnings and enable YJIT.
ENV RUBYOPT="-W:no-deprecated --yjit"

ENV RACK_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

WORKDIR /usr/src/app

# Install system dependencies.
RUN apk add --no-cache --update g++ make

# Alpine Linux does not have a glibc-compatible library installed which can
# cause problems with running gems like Nokogiri.
#
# See: https://github.com/sparklemotion/nokogiri/issues/2430
RUN apk add --no-cache --update gcompat

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf vendor/bundle/ruby/3.2.0/cache/*.gem \
    && find vendor/bundle/ruby/3.2.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

COPY . .

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
