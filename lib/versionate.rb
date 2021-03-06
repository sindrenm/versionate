require "versionate/version"
require "versionate/adapters/bundler"

require "versionate/api_adapter"
require "versionate/configuration"
require "versionate/versioner"

module Versionate

  class << self

    def versionate(gemfile, options)
      versioner.versionate gemfile, options
    end

    def configure
      yield config if block_given?
    end

    def config
      @config ||= Versionate::Configuration.new
    end

    private

    def versioner
      @versioner ||= Versionate::Versioner.new
    end

  end

end
