module Versionate
  class Versioner
    GEM_REGEXP     = /^\s*gem ['"](?<name>.+?)['"](?<extra>,.+$?)?/
    VERSION_REGEXP = /^(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)/

    def versionate(filename, options = {})
      result = process filename, options

      File.open filename, "w" do |file|
        file.write result
      end
    end

    def latest_version_for(gem_name)
      provider.info(gem_name.to_sym)["version"]
    end

    def process(filename, options = {})
      patch     = options.fetch("patch", true)
      specifier = options["specifier"]

      orig_file = File.open(filename)
      tmp = StringIO.new
        
      orig_file.each do |line|
        gem_name = gem_and_only_gem_from_line line

        if gem_name
          version = latest_version_for gem_name

          version = remove_patch_version version unless patch
          version = with_specifier(specifier, version) if specifier

          tmp.puts "#{line.chomp}, '#{version}'"
        else
          tmp.puts line
        end
      end

      orig_file.close

      tmp.rewind
      result = tmp.read

      tmp.close

      result
    end

    def gem_and_only_gem_from_line(line)
      match = line.match GEM_REGEXP
      return nil unless match
      return nil if match[:extra]

      match[:name]
    end

    private

    def provider
      @provider ||= ApiAdapter.new.provider
    end

    def remove_patch_version(version)
      version.match VERSION_REGEXP do |match|
        [ match[:major], match[:minor] ].join "."
      end
    end

    def with_specifier(specifier, version)
      "#{specifier} #{version}"
    end
  end
end
