#ruby

require 'bundler/setup'
require 'sinatra'
require 'json'
require 'active_support/core_ext/string'


def get_link(phrase)
  message = nil
  emoji = nil
  begin
    # tokens = phrase.split.try(:upcase)
    tokens = phrase.split(" ")
    item = nil
    tokens.each do |value|
      value = value.try(:upcase)
      item = value[1..99] if (value[0] == 'D' and value[1] == 'E')
    end
    tokens.each do |value|
      value = value.try(:upcase)
      item = value[1..99] if (value[0] == 'U' and value[1] == 'S')
    end
    
    
    if item
      # puts "Parsed: #{phrase} -> {item}"
      message = "> <https://rally1.rallydev.com/#/#{ENV['SLACK_TOKEN']}/search?keywords=#{item}|#{item}>"
      emoji = ":nerd:"
    else
      # puts "Parsed: #{phrase} -> {item}"
      message = "> #{phrase}  #{item_identifier}  #{us_identifier}"
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
