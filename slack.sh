#!/usr/bin/env bash

# Slack incoming web-hook URL and user name
url='https://hooks.slack.com/services/FHCJLSDF/JFNAFRG965/NrE2fURkfQ1Kf1Ey9y8OsTF'
username='Zabbix'

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (PROBLEM or RECOVERY)
# Message = $3 (whatever message the Zabbix action sends)

to="$1"
subject="$2"

# Message emoji depending on the subject
if [ "$subject" == 'RECOVERY' ]; then
	emoji=':ok_hand:'
elif [ "$subject" == 'PROBLEM' ]; then
	emoji=':heavy_exclamation_mark:'
else
	emoji=':loudspeaker:'
fi

# The message that we want to send to Slack is the "subject" value ($2 / $subject - that we got earlier)
#  followed by the message that Zabbix actually sent us ($3)
message="${subject}: $3"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"channel\": \"${to}\", \"username\": \"${username}\", \"text\": \"${message}\", \"icon_emoji\": \"${emoji}\"}"
curl -m 5 --data-urlencode "${payload}" $url
