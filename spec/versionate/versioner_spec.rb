require "spec_helper"

module Versionate

  describe Versioner do
    describe "#latest_version_for" do
      it "returns the latest version of the specified gem" do
        expect(subject.latest_version_for :factory_girl_rails)
          .to eq GemsMock::GEM_MOCK_VERSIONS[:factory_girl_rails]
      end
    end
  end

end
