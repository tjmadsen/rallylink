#ruby

require 'bundler/setup'
require 'sinatra'
require 'json'
require 'active_support/core_ext/string'


def get_link(phrase)
  message = nil
  emoji = nil
  begin
    item_identifier = phrase.split.first.try(:upcase)
    item_identifier = item_identifier[1..99] if (item_identifier[0] == 'D' && item_identifier[1] == 'E')
    item_identifier = item_identifier[1..99] if (item_identifier[0] == 'U' && item_identifier[1] == 'S')
    item = nil
    if (item_identifier[0] == 'U' && item_identifier[1] == 'S')
      puts "{zone_identifier}"
      item = item_identifier
    end
    if (item_identifier[0] == 'D' && item_identifier[1] == 'E')
      puts "{zone_identifier}"
      item = item_identifier
    end
    
    if item
      # puts "Parsed: #{phrase} -> #{time.strftime('%I:%M%P')} #{time.zone}"
      message = "> <https://rally1.rallydev.com/#/{ENV['SLACK_TOKEN']}/search?keywords={item}|{item}>"
      emoji = ":nerd:"
    end
    [message, emoji]
  rescue => e
    p e.message
    [nil, nil]
  end
end

module RallyLink
  class Web < Sinatra::Base

    before do
      return 401 unless request["token"] == ENV['SLACK_TOKEN']
      return 401 unless ENV['SLACK_TOKEN'] !=  nil
    end

    get '/rally' do
      message, emoji = get_link(params[:text])
      status 200
      
      reply = { username: 'rallylink', icon_emoji: emoji, text: message } 
      return reply.to_json
    end
    
    post "/time" do
      message, emoji = get_link(request['text'])
      status 200
      
      reply = { username: 'rallylink', icon_emoji: emoji, text: message } 
      return reply.to_json
    end
  end
end
