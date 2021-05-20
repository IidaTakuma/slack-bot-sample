require 'sinatra'
require 'dotenv'
require 'json'

require './slack'

Dotenv.load
slack = SlackAPIWrapper.new(ENV['SLACK_BOT_TOKEN'])

# http://localhost:4567でブラウザからアクセスできる
get '/' do
  'hello'
end

# slackに発生したイベントを受け取る場所
post '/' do
  body = request.body.read
  json_body = JSON.parse(body, symbolize_names: true)
  # APIサーバーが受け取ったデータをターミナルに表示
  puts json_body

  # 認証に必要
  return json_body[:challenge] if json_body[:type] == 'url_verification'

  event = json_body[:event]
  # メンションを受け取った時の処理
  if event[:type] == 'app_mention'
    # 受け取ったテキストの取得
    text = event[:text]
    puts text
    channel = event[:channel]
    user = event[:user]
    # slackにメッセージを送信
    slcak.chat_post_message("Hello, <@#{user}>, from #{text}}", channel)
  end
end
