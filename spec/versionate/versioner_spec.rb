require "spec_helper"

module Versionate

  describe Versioner do
    let(:filename) { "Gemfile" }

    describe "#latest_version_for" do
      it "returns the latest version of the specified gem" do
        expect(subject.latest_version_for :factory_girl_rails)
          .to eq GemsMock::GEM_MOCK_VERSIONS[:factory_girl_rails]
      end
    end

    describe "#process" do
      let(:orig_file) { StringIO.new fixture :original_gemfile }

      before do
        allow(File).to receive(:open)
          .with(filename)
          .and_return orig_file
      end

      it "appends versions to unversioned gems" do
        result = subject.process filename

        expect(result).to eq fixture :processed_gemfile
      end
    end

    describe "#gem_and_only_gem_from_line" do
      def result
        subject.gem_and_only_gem_from_line line
      end

      context "if the line is a gem line" do
        context "if it does not have anything following the gem name" do
          let(:line) { "gem 'rails'" }

          it "returns the gem name" do
            expect(result).to eq "rails"
          end
        end

        context "if it has something following the gem name" do
          let(:line) { "gem 'rails', '1.2.3'" }

          it "returns nil" do
            expect(result).to be_nil
          end
        end
      end

      context "if the line is not a gem line" do
        let(:line) { "# Comment line" }

        it "returns false" do
          expect(result).not_to be
        end
      end
    end
  end

end
