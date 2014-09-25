require "versionate/version"
require "versionate/configuration"

module Versionate

  class << self

    def configure
      yield config if block_given?
    end

    def config
      @config ||= Versionate::Configuration.new
    end

  end

end
