class SlackAPIWrapper
  SLACK_API_URL = 'https://slack.com/api'

  def initialize(bot_token)
    @bot_token = bot_token
  end

  def gen_url(endpoint)
    "SLACK_API_URL/#{endpoint}"
  end

  def chat_post_message(text, channel)
    header = {
      'Content-type': 'application/json',
      'Authorization': "Bearer #{bot_token}"
    }
    body = {
      'text': text,
      'channel': channel
    }
    [200, header, body]
  end
end
