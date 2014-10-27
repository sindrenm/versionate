require "spec_helper"

module Versionate

  describe Versioner do
    let(:filename)    { "Gemfile" }
    let(:output_file) { StringIO.new }

    before do
      allow(File).to receive(:open)
        .with(filename, "w")
        .and_yield output_file
    end

    after { output_file.close }

    describe "#versionate" do
      it "processes the file with the correct options" do
        options = { "no-patch" => true, "specifier" => "=" }

        expect(subject).to receive(:process)
          .with("Gemfile", options)

        subject.versionate filename, options
      end

      it "overwrites the file with the processed content" do
        processed_content = "Processed content"

        allow(subject).to receive(:process)
          .and_return processed_content

        subject.versionate filename

        output_file.rewind

        expect(output_file.read).to eq processed_content
      end
    end

    describe "#latest_version_for" do
      context "when asking for a stable release" do
        it "returns the latest stable version of the specified gem" do
          expect(subject.latest_version_for :factory_girl_rails, stable: true)
            .to eq GemsMock::GEM_MOCK_STABLE_VERSIONS[:factory_girl_rails]
        end
      end

      context "when asing for any release" do
        it "returns the latest prerelease for the specified gem" do
          expect(subject.latest_version_for :factory_girl_rails, stable: false)
            .to eq "4.4.2.beta1"
        end
      end
    end

    describe "#process" do
      let(:orig_file) { StringIO.new fixture :original_gemfile }

      before do
        allow(File).to receive(:open)
          .with(filename)
          .and_return orig_file
      end

      context "when patch version should be kept" do
        it "removes the patch version" do
          expect(subject).not_to receive(:remove_patch_version)

          subject.process filename, "patch" => true
        end
      end

      context "when patch version should be removed" do
        it "removes the patch version" do
          expect(subject).to receive(:remove_patch_version)
            .at_least(:once)

          subject.process filename, "patch" => false
        end
      end

      context "when given a version specifier" do
        it "prepends the version with that specifier" do
          version = kind_of String
          expect(subject).to receive(:with_specifier)
            .with("~>", version)
            .at_least(:once)

          subject.process filename, "specifier" => "~>"
        end
      end

      context "when not given a version specifier" do
        it "defaults to using no specifier" do
          expect(subject).not_to receive(:with_specifier)

          subject.process filename
        end
      end

      it "appends versions to unversioned gems" do
        result = subject.process filename

        expect(result).to eq fixture :processed_gemfile
      end

      it "defaults to keeping the patch version" do
        expect(subject).not_to receive :remove_patch_version

        subject.process filename
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
