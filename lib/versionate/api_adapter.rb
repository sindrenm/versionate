require 'gems'

module Versionate
  class ApiAdapter
    def provider
      case Versionate.config.environment
      when :test
        GemsMock
      when :production
        ::Gems
      end
    end
  end
end
