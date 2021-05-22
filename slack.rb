require 'net/http'
require 'json'

SLACK_API_URL = 'https://slack.com/api'.freeze

class SlackAPIWrapper
  def initialize(bot_token)
    @bot_token = bot_token
  end

  def gen_url(endpoint)
    "#{SLACK_API_URL}/#{endpoint}"
  end

  def chat_post_message(text, channel)
    # https://api.slack.com/methods/chat.postMessage へPostする
    header = {
      'Content-type': 'application/json',
      'Authorization': "Bearer #{@bot_token}"
    }
    body = {
      'text': text,
      'channel': channel
    }

    uri = URI.parse(gen_url('chat.postMessage'))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    http.post(uri.path, body.to_json, header)
  end
end
