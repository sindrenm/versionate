require "versionate/version"
require "versionate/api_adapter"
require "versionate/configuration"
require "versionate/versioner"

module Versionate

  class << self

    def versionate gemfile
      versioner.versionate gemfile
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
