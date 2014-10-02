require "thor"

require "versionate"

module Versionate
  class CLI < Thor
    DEFAULT_GEMFILE_NAME = "Gemfile"

    desc "version FILENAME", "Versions a given file (default: Gemfile)"
    def version(file = DEFAULT_GEMFILE_NAME)
      Versionate.versionate file
    end

    default_task :version

  end
end
