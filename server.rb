require 'sinatra'
require 'dotenv'
require 'json'

require './slack'

Dotenv.load
slack = SlackAPIWrapper.new(ENV['SLACK_BOT_TOKEN'])

get '/' do
  'hello'
end

post '/' do
  body = request.body.read
  json_body = JSON.parse(body, symbolize_names: true)

  return json_body[:challenge] if json_body[:type] == 'url_verification'

  event = json_body[:event]

  # メンションを受け取った時の処理
  if event[:type] == 'app_mention'
    text = event[:text]
    channel = event[:channel]
    user = event[:user]

    slack.chat_post_message("Hello, <@#{user}>, from #{text}", channel)
  end
  return 200
end
