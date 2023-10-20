#!/bin/sh

# Wait for Postgres to start
echo "Waiting for PostgreSQL to start..."
until pg_isready -h db -U postgres; do
    echo "Postgres is unavailable - sleeping"
    sleep 1
done

echo "PostgreSQL started"

# Install dependencies
mix deps.get

# Create and migrate database
mix ecto.create
mix ecto.migrate

# Start phoenix server
mix phx.server