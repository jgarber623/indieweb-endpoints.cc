FROM ruby:3.2.2-alpine3.17

EXPOSE 8080

# Configure editors and pagers.
ENV EDITOR="vi" \
    VISUAL="code --wait" \
    PAGER="less" \
    LESS="-FMR"

# Silence Ruby deprecation warnings and enable YJIT.
ENV RUBYOPT="-W:no-deprecated --yjit"

# Configure ruby/debug gem.
ENV RUBY_DEBUG_HISTORY_FILE="/workspace/.rdbg_history" \
    RUBY_DEBUG_SAVE_HISTORY="1000"

ENV RACK_ENV=development

WORKDIR /workspace

# Install system dependencies.
RUN apk add --no-cache --update g++ git less make openssh

# Alpine Linux does not have a glibc-compatible library installed which can
# cause problems with running gems like Nokogiri.
#
# See: https://github.com/sparklemotion/nokogiri/issues/2430
RUN apk add --no-cache --update gcompat

# Install system-wide gems.
RUN gem install --no-document rainbow rerun