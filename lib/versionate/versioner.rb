module Versionate
  class Versioner
    GEM_REGEXP = /^\s*gem ['"](?<name>.+?)['"](?<extra>,.+$?)?/

    def latest_version_for(gem_name)
      provider.info(gem_name.to_sym)["version"]
    end

    def process(filename)
      orig_file = File.open(filename)
      tmp = StringIO.new
        
      orig_file.each do |line|
        gem_name = gem_and_only_gem_from_line line

        if gem_name
          version = latest_version_for gem_name
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
  end
end
