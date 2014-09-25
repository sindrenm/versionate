module Versionate
  class Configuration
    attr_accessor :environment

    def initialize
      @environment = :production
    end
  end
end
