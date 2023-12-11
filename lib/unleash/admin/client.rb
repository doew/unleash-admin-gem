require 'zeitwerk'
require "uri"
require "net/http"
# frozen_string_literal: true

module Unleash
  module Admin
    class Client
      def initialize(config = Configuration.new)
        @config = config
      end

      def get_features
        api_call(:get, "/api/admin/projects/#{@config.project}features")
      end

      def api_call(method, path, body = nil)
        url = URI.parse(@config.unleash_server_url + path)
        case method
        when :get
          request = Net::HTTP::Get.new(url)
        when :post
          request = Net::HTTP::Post.new(url)
        when :put
          request = Net::HTTP::Put.new(url)
        when :delete
          request = Net::HTTP::Delete.new(url)
        end
        request["Accept"] = "application/json"
        request["Authorization"] = @config.unleash_admin_api_key
        request.body = body if body
        use_ssl = url.scheme == "https"
        response = Net::HTTP.start(url.hostname, url.port, use_ssl: use_ssl) do |http|
          http.request(request)
        end
        response.code, JSON.parse(response.body)
      end
    end
  end
end
