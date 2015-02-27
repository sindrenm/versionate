require "spec_helper"

module Versionate
  describe Adapters::Bundler do
    let!(:bundler_instance) { ::Bundler.load }

    let(:rake_version) { "10.4.2" }
    let(:rake_spec) do
      Gem::Specification.new do |s|
        s.name = "rake"
        s.version = Gem::Version.new(rake_version)
      end
    end

    before { allow(bundler_instance).to receive(:specs).and_return [rake_spec] }

    describe "::info" do
      context "when Bundler can find the gem" do
        it "returns information about the given gem" do
          expect(described_class.info("rake"))
            .to eq({ "version" => rake_version })
        end
      end

      context "when Bundler cannot find the gem" do
        it "raises a Gem::LoadError" do
          expect { described_class.info("nonexistant") }
            .to raise_error Gem::LoadError
        end
      end
    end

    describe "::versions" do
      it "returns a single version in an array" do
        expect(described_class.versions("rake"))
          .to eq [ { "number" => rake_version } ]
      end
    end
  end
end
