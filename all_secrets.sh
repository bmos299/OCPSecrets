#!/bin/bash

find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp ../create_secret.sh . && ./create_secret.sh && rm create_secret.sh" \;
