require "versionate"

require "coveralls"
Coveralls.wear!

def fixture file
  File.read "spec/fixtures/#{file}"
end

class GemsMock
  GEM_MOCK_STABLE_VERSIONS = {
    factory_girl_rails: "4.4.1",
    json: "1.8.1",
    pry: "0.10.1",
    rack: "1.5.2",
    rails: "4.1.6",
    rake: "10.3.2",
    rspec: "3.1.0",
    thor: "3.1.0",
    unicorn: "4.8.3",
    versionate: "0.1.0",
  }

  GEM_MOCK_ALL_VERSIONS = {
    factory_girl_rails: [
      { "number" => "4.4.2.beta1" },
      { "number" => "4.4.1" },
    ],
    json: [
      { "number" => "2.0.0.rc2" },
      { "number" => "1.8.1" },
    ],
  }

  def self.info(gem_name)
    { "version" => GEM_MOCK_STABLE_VERSIONS[gem_name.to_sym] }
  end

  def self.versions(gem_name)
    GEM_MOCK_ALL_VERSIONS[gem_name.to_sym]
  end
end

Versionate.configure { |c| c.environment = :test }
