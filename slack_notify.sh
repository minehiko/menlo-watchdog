#!/bin/sh

USERNAME="MSIP障害検知"
CHANNEL="#monitor"
ICON=":scream:"
WEBHOOK_URL="https://hooks.slack.com/services/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"

author="macnica menlo team"


data=`cat << EOF
    payload={
    "channel": "$CHANNEL",
    "username": "$USERNAME",
    "icon_emoji": "$ICON",
    "link_names": 1 ,
    "attachments": [{
        "fallback": "障害検知",
        "color": "#003399",
        "pretext": "[AWS-1]自動監視システムで問題を検知しました。:fire::fire::fire::" ,
        "title": ":exclamation::exclamation:緊急:exclamation::exclamation:",
        "text": "確認をお願いします:pray: @$author:"
      }]
  }
EOF`

curl -X POST --data-urlencode "$data" $WEBHOOK_URL
