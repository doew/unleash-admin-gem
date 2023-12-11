# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.push_dir(__dir__+"/../")
loader.setup

module Unleash
  module Admin
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
      end
    end
    class Error < StandardError; end
  end
end
