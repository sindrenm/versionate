module Versionate
  class ApiAdapter
    def provider
      case Versionate.config.environment
      when :test
        GemsMock
      when :production
        Adapters::Bundler
      end
    end
  end
end
