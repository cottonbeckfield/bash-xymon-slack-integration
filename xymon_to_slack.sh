#!/bin/bash
# Please reference Slack Incoming Webhooks for more information.
# https://api.slack.com/incoming-webhooks

# Variables for Slack
url="[WEBHOOKURL]"
channel="#${RCPT}"

# Variables for Xymon
hostname=$BBHOSTNAME      # The name of the host that the alert is about
alert_color=$BBCOLORLEVEL       # The color of the alert: "red", "yellow" or "purple"
alert_msg=$BBALPHAMSG           # The full text of the status log triggering the alert
alert_title="$BBHOSTSVC $level" # HOSTNAME.SERVICE that the alert is about.

# If I'm gonna output a message, mind as well timestamp it.
time_stamp() {
  date +%Y-%m-%d:%H:%M:%S"%R $*"
}

# Check the color and set Slack payload variables.
case $alert_color in
  red)
    emoji=":red_circle:"
    color="danger" # Slack Side Bar
    ;;
  yellow)
    emoji=":warning:"
    color="warning" # Slack Side Bar
    ;;
  green)
    emoji=":ok:"
    color="good" # Slack Side Bar
    ;;
  purple)
    time_stamp "xymon_to_slack.sh: Received Purple Alert. Ignoring."
    exit
    ;;
esac

# Setup the payload for delivery to Slack.
payload=$(< <(cat <<EOF
{
  "channel": "${channel}",
  "username": "${hostname}",
  "icon_emoji": "${emoji}",
  "attachments": [
    {
      "title": "${alert_title}",
      "color": "${color}",
      "text": "${alert_msg}",
        }
      ]
    }
  ]
}
EOF
))

# Deliver the Payload to Slack
curl -s -X POST --data-urlencode "payload=${payload}" ${url}
