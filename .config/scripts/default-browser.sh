#!/bin/bash

BROWSER_ID=$(
  defaults export com.apple.LaunchServices/com.apple.launchservices.secure - 2>/dev/null |
  plutil -extract LSHandlers json -o - - |
  jq -r '
    .[] |
    select(.LSHandlerURLScheme == "http") |
    .LSHandlerRoleAll
  '
)

open -b "$BROWSER_ID" "$1"
