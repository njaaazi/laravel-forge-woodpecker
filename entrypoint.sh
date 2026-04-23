#!/bin/sh
set -e

deploy_with_webhook() {
    url="$PLUGIN_TRIGGER_URL"
    if [ -n "$PLUGIN_QUERY" ]; then
        case "$url" in
            *\?*) url="${url}&${PLUGIN_QUERY}" ;;
            *)    url="${url}?${PLUGIN_QUERY}" ;;
        esac
    fi

    curl \
        --fail \
        --silent \
        --show-error \
        --user-agent "Forge-WoodpeckerPlugin/1.0" \
        --max-time 5 \
        --connect-timeout 5 \
        --request 'POST' \
        "$url"
}

deploy_with_api() {
    curl \
        --fail \
        --silent \
        --show-error \
        --user-agent "Forge-WoodpeckerPlugin/1.0" \
        --max-time 5 \
        --connect-timeout 5 \
        --request 'POST' \
        -H "Authorization: Bearer $PLUGIN_API_KEY" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        "https://forge.laravel.com/api/v1/servers/$PLUGIN_SERVER_ID/sites/$PLUGIN_SITE_ID/deployment/deploy"
}

if [ -n "$PLUGIN_TRIGGER_URL" ]; then
    deploy_with_webhook
elif [ -n "$PLUGIN_API_KEY" ]; then
    if [ -z "$PLUGIN_SERVER_ID" ] || [ -z "$PLUGIN_SITE_ID" ]; then
        echo "PLUGIN_SERVER_ID and PLUGIN_SITE_ID environment variables must be set. Exiting."
        exit 1
    fi

    deploy_with_api
else
    echo "Either a PLUGIN_TRIGGER_URL or PLUGIN_API_KEY environment variable must be set to use the Laravel Forge Woodpecker plugin. Exiting."
    exit 1
fi
