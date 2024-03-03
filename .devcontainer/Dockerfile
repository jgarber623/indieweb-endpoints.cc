FROM ruby:3.3.0-slim-bookworm

EXPOSE 8080

# Configure editors and pagers.
ENV EDITOR="vi" \
    VISUAL="code --wait" \
    PAGER="less" \
    LESS="-FMR"

# Configure ruby/debug gem.
ENV RUBY_DEBUG_HISTORY_FILE="/workspace/.rdbg_history" \
    RUBY_DEBUG_SAVE_HISTORY="1000"

# Configure application environment.
ENV RACK_ENV="development"

WORKDIR /workspace

# Install system dependencies.
RUN apt update && \
    apt install --no-install-recommends --yes \
      g++ \
      git \
      less \
      libjemalloc2 \
      make \
      && \
    rm -rf /var/lib/apt/lists/*

# Configure memory allocation.
ENV LD_PRELOAD="/usr/lib/aarch64-linux-gnu/libjemalloc.so.2"

# Install system-wide gems.
RUN gem install --no-document rainbow rerun
