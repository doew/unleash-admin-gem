# frozen_string_literal: true

module Unleash
  module Admin
    class Configuration
      attr_accessor :admin_api_key, :server_url, :project, :environment

      def initialize
        @admin_api_key =  ENV.key?('UNLEASH_ADMIN_API_KEY') ? ENV['UNLEASH_ADMIN_API_KEY'] : 'dummy'
        @server_url =  ENV.key?('UNLEASH_SERVER_URL') ? ENV['UNLEASH_SERVER_URL'] : 'http://localhost:4242'
        @project = ENV.key?('UNLEASH_PROJECT_NAME') ? ENV['UNLEASH_PROJECT_NAME'] : 'default' 
        @environment = ENV.key?('UNLEASH_ENVIRONMENT') ? ENV['UNLEASH_ENVIRONMENT'] : 'development'
  
        yield(self) if block_given?
      end
    end
  end
end
