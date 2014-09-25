require "spec_helper"

describe Versionate do

  subject { described_class }

  describe "::versionate" do
    it "delegates to the versioner" do
      expect_any_instance_of(Versionate::Versioner)
        .to receive(:versionate).with("Gemfile")

      subject.versionate "Gemfile"
    end
  end

  describe "::configure" do
    it "yields to the configuration" do
      expect { |block| subject.configure(&block) }.to yield_control
    end
  end

  describe "::config" do
    it "returns an instance of Configuration" do
      expect(subject.config).to be_a Versionate::Configuration
    end
  end

end
