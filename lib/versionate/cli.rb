require "thor"

require "versionate"

module Versionate
  class CLI < Thor
    DEFAULT_GEMFILE_NAME = "Gemfile"

    desc "version [FILENAME]", "Versions a given file (default: Gemfile)"

    option :patch,
      type: :boolean,
      desc: "Whether or not to keep patch version (default: true)"

    option :specifier,
      type: :string,
      desc: "Specifier to be prepended to version"
    def version(file = DEFAULT_GEMFILE_NAME)
      Versionate.versionate file, options
    end

    default_task :version

  end
end
