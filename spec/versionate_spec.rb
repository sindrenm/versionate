require "spec_helper"

describe Versionate do

  subject { described_class }

  describe "::configure" do
    it "yields to the configuration" do
      expect { |block| subject.configure(&block) }.to yield_control
    end
  end

end
