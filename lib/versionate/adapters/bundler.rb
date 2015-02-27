require 'bundler'

module Versionate
  module Adapters
    class Bundler
      def self.info(gem_name)
        found = specs.find { |spec| spec.name == gem_name.to_s }

        if found.nil?
          error = "Could not find '#{gem_name}'. Please run `bundle install`."
          raise Gem::LoadError.new error
        end

        { "version" => found.version.to_s }
      end

      def self.versions(gem_name)
        [ { "number" => info(gem_name)["version"] } ]
      end

      private

      def self.specs
        @specs ||= ::Bundler.load.specs
      end
    end
  end
end
