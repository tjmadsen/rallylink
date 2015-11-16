# Rally Link Creator for Slack by tjmadsen


## Overview

Using #rally, and mentioning a user story or defect in format "USXXX" or "DEXXX", the bot will respond with a link to the story.

![TimeLord Example](https://s3.amazonaws.com/f.cl.ly/items/0g1G0u2B2e000e3m0P1s/timelord.png)

## Usage

### Preparation

Rally Link Creator for Slack uses a Slack [Outgoing WebHooks](https://slack.com/services/new/outgoing-webhook) integration for catching the `#rally` request and firing it to your Rally Link Creator for Slack service. You'll need to [add a new Outgoing WebHook](https://slack.com/services/new/outgoing-webhook) first so you'll have the `SLACK_TOKEN` available for the actual Rally Link Creator for Slack deployment steps below, and then you'll need to add the `RALLY_INSTANCE` of your Rally Project.

### Deployment

#### Heroku

```
$ heroku create
$ heroku config:set SLACK_TOKEN=...
$ heroku config:set RALLY_INSTANCE=...
$ git push heroku master
```

### WebHook Settings

Once your Rally Link Creator for Slack application has been deployed you'll need to go back to your Outgoing Webhook page and update the Integration Settings. Generally speaking you'll want to use settings like these (adjust as necessary):

* Channel: `Any`
* Trigger Word: `#rally`
* URL: `http://slack-Rally-123.herokuapp.com/rally` (the `/rally` endpoint is mandatory)
* Label: `RallyLink`

