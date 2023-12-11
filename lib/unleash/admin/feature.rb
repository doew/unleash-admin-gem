require 'zeitwerk'
# frozen_string_literal: true

module Unleash
  module Admin
    class Feature
      attr_accessor :name, :description, :project, :enabled, :stale, :favorite, :impression_data, :created_at, :archived_at

      def initialize(name, description, project, enabled, stale, favorite, impression_data, created_at, archived_at)
        @name = name
        @description = description
        @project = project
        @enabled = enabled
        @stale = stale
        @favorite = favorite
        @impression_data = impression_data
        @created_at = created_at
        @archived_at = archived_at
      end
    end
  end
end
