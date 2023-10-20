# No MUSL please...
ARG ELIXIR_VERSION=1.15-otp-25-slim
ARG PHOENIX_VERSION=1.7.9
ARG PORT=4000

# Use an official Elixir runtime as a parent image
FROM elixir:${ELIXIR_VERSION} AS build

WORKDIR /app

# Install build dependencies
RUN apt-get update && \
    apt-get install -y build-essential postgresql-client inotify-tools && \
    rm -rf /var/lib/apt/lists/*

# Install hex and rebar
RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./

# Install project dependencies
RUN mix do deps.get, deps.compile

# Eventually we should volume code in (devcontainer?)

# Files that are edited least often to most often
COPY scripts scripts
COPY assets assets
COPY config config
COPY priv priv
COPY lib lib
COPY test test

# Compile the project
RUN mix do compile

# Expose port 4000 for the app
EXPOSE ${PORT}

ENTRYPOINT ["/app/scripts/docker-entrypoint.sh"]