require 'zeitwerk'
# frozen_string_literal: true

module Unleash
  module Admin
    class Configuration
      attr_accessor :unleash_admin_api_key, :unleash_server_url, :unleash_project_name, :unleash_environment

      def initialize
        @unleash_admin_api_key = ENV['UNLEASH_ADMIN_API_KEY'] if ENV.key? 'UNLEASH_ADMIN_API_KEY'
        @unleash_server_url = ENV['UNLEASH_SERVER_URL'] if ENV.key? 'UNLEASH_SERVER_URL'
        @unleash_project_name = ENV['UNLEASH_PROJECT_NAME'] if ENV.key? 'UNLEASH_PROJECT_NAME'
        @unleash_environment = ENV['UNLEASH_ENVIRONMENT'] if ENV.key? 'UNLEASH_ENVIRONMENT'
  
        yield(self) if block_given?
      end
    end
  end
end
