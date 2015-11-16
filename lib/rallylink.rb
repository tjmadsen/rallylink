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
    de_identifier = item_identifier
    de_identifier = de_identifier[1..99] if (de_identifier[0] == 'D' and de_identifier[1] == 'E')
    us_identifier = item_identifier
    us_identifier = us_identifier[1..99] if (us_identifier[0] == 'U' and us_identifier[1] == 'S')
    item = nil
    if (de_identifier[0] == 'D' and de_identifier[1] == 'E')
      puts "#{item_identifier}"
      item = item_identifier
    end
    if (us_identifier[0] == 'U' and us_identifier[1] == 'S')
      puts "#{item_identifier}"
      item = item_identifier
    end
    
    if item
      # puts "Parsed: #{phrase} -> {item}"
      message = "> <https://rally1.rallydev.com/#/#{ENV['SLACK_TOKEN']}/search?keywords=#{item}|#{item}>"
      emoji = ":nerd:"
    else
      # puts "Parsed: #{phrase} -> {item}"
      message = "> #{phrase}"
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
    
    post "/rally" do
      message, emoji = get_link(request['text'])
      status 200
      
      reply = { username: 'rallylink', icon_emoji: emoji, text: message } 
      return reply.to_json
    end
  end
end
