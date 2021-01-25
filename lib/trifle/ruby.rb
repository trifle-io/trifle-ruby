# frozen_string_literal: true

require 'trifle/ruby/driver/redis'
require 'trifle/ruby/mixins/packer'
require 'trifle/ruby/nocturnal'
require 'trifle/ruby/configuration'
require 'trifle/ruby/resource'
require 'trifle/ruby/version'

module Trifle
  module Ruby
    class Error < StandardError; end

    def self.config
      @config ||= Configuration.new
    end

    def self.configure
      yield(config)

      config
    end

    def self.track(key:, at:, values:, driver: nil)
      config.ranges.map do |range|
        Resource.new(
          key: key,
          range: range,
          at: Nocturnal.new(at).send("beginning_of_#{range}"),
          driver: driver
        ).increment(**values)
      end
    end

    def self.values_for(key:, from:, to:, range:, driver: nil)
      Nocturnal.timeline(from: from, to: to, range: range).map do |at|
        Resource.new(key: key, range: range, at: at, driver: driver).values
      end
    end
  end
end
