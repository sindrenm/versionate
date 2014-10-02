require "thor"

require "versionate"

module Versionate
  class CLI < Thor
    DEFAULT_GEMFILE_NAME = "Gemfile"

    desc "process [FILENAME]", "Processes a given file (default: Gemfile)"

    option :patch,
      type: :boolean,
      desc: "Whether or not to keep patch version (default: true)"

    option :specifier,
      type: :string,
      desc: "Specifier to be prepended to version"
    def process(file = DEFAULT_GEMFILE_NAME)
      Versionate.versionate file, options
    end

    desc "version", "Display the version of versionate"

    def version
      puts Versionate::VERSION
    end

    default_task :process

  end
end
