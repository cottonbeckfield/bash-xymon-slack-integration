# bash-xymon_to_slack
This is a small script that uses Slack API Webhooks to send alerts from Xymon (Hobbit) to Slack.

For additional configuration options, reference "[Slack Incoming Webhooks](https://api.slack.com/incoming-webhooks)" for more information.

# Requirements
You will need to setup Webhooks Integration with your channel. 
For more information, see "[Slack's Webhook Integration](https://nordstrom.slack.com/apps/new/A0F7XDUAZ-incoming-webhooks)"

This will provide you with a webhook URL. You will need this.

# Installing the Script
Place the xymon_to_slack.sh script on your Xymon server.

Example: 
```
/etc/xymon/scripts/xymon_to_slack.sh
```

# Updating alerts.cfg
Update the alerts.cfg and call the script on the Hosts you want. In this case, I'm applying it to all hosts.

Example:
```HOST=*
  SCRIPT /usr/local/xymon/server/etc/scripts/xymon_to_slack.sh uis_alerts DURATION>10
```
