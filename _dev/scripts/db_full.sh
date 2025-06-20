#!/bin/sh
docker compose exec rails rails db:drop db:create db:migrate db:seed