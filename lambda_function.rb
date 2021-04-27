require 'json'
require 'slack-notifier'
require "net/http"

DEFAULT_ALERT_NAME = 'SidekiqQueueAlert'

def lambda_handler(event:, context:)
  if event["error"]
    notify_slack "#{event["msg"]}"
  else
    notify_slack "#{alert_name}:#{event["queue_type"]}\nSizeThreshold: #{event["size_threshold"]} SizeCurrent: #{event["size"]}"
    notify_slack "#{alert_name}:#{event["queue_type"]}\nLatencyThreshold: #{event["latency_threshold"]} LatencyCurrent: #{event['latency']}"
  end
rescue => e
  notify_slack e.message
end

def alert_name
  ENV['ALERT_NAME'] || DEFAULT_ALERT_NAME
end

def notify_slack(message)
  slack_notifier.ping message
end

def slack_notifier
  raise 'SLACK_WEBHOOK_URL を設定してください。' if ENV['SLACK_WEBHOOK_URL'].nil? || ENV['SLACK_WEBHOOK_URL'].empty?
  @slack_notifier ||= Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], http_options: { open_timeout: 180 }
end
