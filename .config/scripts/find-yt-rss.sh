#!/usr/bin/env bash

extract_rss_info() {
    local youtube_channel_url="$1"

    local page
    page=$(curl -Ls "$youtube_channel_url")

    local channel_id
    channel_id=$(echo "$page" |
        sed -n 's/.*"externalId":"\(UC[^"]*\)".*/\1/p' |
        head -n1
    )

    local display_name
    display_name=$(echo "$page" |
        sed -n 's/.*"title":"\([^"]*\)".*/\1/p' |
        head -n1
    )

    if [[ -n "$channel_id" && -n "$display_name" ]]; then
        echo "[[https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id][$display_name]]"
    else
        echo "Failed to extract data for $youtube_channel_url"
    fi
}

youtube_channel_urls=(
)

for url in "${youtube_channel_urls[@]}"; do
    extract_rss_info "$url"
done
