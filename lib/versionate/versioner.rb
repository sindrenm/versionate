module Versionate
  class Versioner
    def latest_version_for(gem_name)
      provider.info(gem_name.to_sym)["version"]
    end

    private

    def provider
      @provider ||= ApiAdapter.new.provider
    end
  end
end
