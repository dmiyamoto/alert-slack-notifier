# Overview

Detail: https://github.com/dmiyamoto/sidekiq-queue-monitor

# How to use

1. Get `Slack incoming webhook URL` .
1. Deploy this module to Lambda and set Environment valiable .

# Deploy

### Manual

1. `bundle install --path vendor/bundle`
1. `zip -r function.zip lambda_function.rb vendor`

# Environment Variable

- `ALERT_NAME`
  - Optional
  - Default: SidekiqQueueAlert.
  - Name of the alert.
- `SLACK_WEBHOOK_URL`
  - Required
  - Slack incoming webhook URL.
  - i.e. https://slack.com/xxxx

# Lambda Settings

- Trigger
  - Lambda client of alertSidekiqQueueAlertForExcaliburProduction
