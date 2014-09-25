require "spec_helper"

module Versionate
  describe ApiAdapter do

    describe "#provider" do
      context "when in a production environment" do
        before { Versionate.configure { |c| c.environment = :production } }

        it "returns the Gems provider" do
          expect(subject.provider).to be Gems
        end
      end

      context "when in a test environment" do
        before { Versionate.configure { |c| c.environment = :test } }

        it "returns the mock provider" do
          expect(subject.provider).to be GemsMock
        end
      end
    end

  end
end
