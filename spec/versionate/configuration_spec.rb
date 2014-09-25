require "spec_helper"

module Versionate
  describe Configuration do

    describe "when initialized" do
      it "defualts environment to production" do
        expect(subject.environment).to be :production
      end
    end

  end
end
