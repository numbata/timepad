require 'json'
require 'net/http'

module Timepad
  class Base
    SUBSCRIBER_KEYS = [
      :email,
      :name, :surnname, :middlename,
      :company, :phone, :comment]

    def request(action, params = {})
      uri = make_uri(action, params)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end

    def make_query(params)
      params.map { |key, value| value.nil? ? '' : "#{key}=#{value}" }.join('&')
    end

    def make_uri(action, params = {})
      params.merge!('id' => @client.id, 'code' => @client.key)
      query = make_query(params)
      object = self.class.name.split('::').last.downcase
      URI("#{Timepad.endpoint.downcase}#{object}_#{action}?#{query}")
    end

    # Convert Array of Hash to Hash
    #
    # @param subscribers [Array]
    # @return [Hash]
    def subscribers_to_hash(subscribers)
      i = 0
      params = {}
      subscribers.each do |subscriber|
        next if subscriber[:email].empty?
        SUBSCRIBER_KEYS.each do |key|
          params["i#{i}_#{key}".to_sym] = subscriber[key] if subscriber[key]
        end
        i += 1
      end
      params
    end
  end
end
