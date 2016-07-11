require 'pushould'
require 'rest-client'
require 'json'

module Pushould
  class Client
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def trigger(room: _room, event: _event, data: _data)
      data = { room: room,
               event: event,
               custom: data }.to_json
      RestClient::Resource.new(@url)
                          .get(params: { data: data },
                               content_type: 'application/json',
                               accept: 'application/json')
    end
  end

  def self.new(args = {})
    raise ArgumentError if args[:url].nil?
    Pushould::Client.new(args[:url])
  end
end
