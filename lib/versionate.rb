require "versionate/version"
require "versionate/configuration"

module Versionate

  class << self

    def configure
      yield config if block_given?
    end

    private

    def config
      @config ||= Versionate::Configuration.new
    end

  end

end
