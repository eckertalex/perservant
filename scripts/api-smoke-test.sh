#!/bin/bash

API_URL="http://localhost:45067/v1"

if ! curl -s --head "$API_URL" > /dev/null; then
    echo "Error: API is not reachable at $API_URL" >&2
    exit 1
fi

curl -s "$API_URL/users/1"

curl -s "$API_URL/users"

curl -s "$API_URL/tasks/1"

curl -s "$API_URL/tasks/2"

curl -s "$API_URL/tasks"
