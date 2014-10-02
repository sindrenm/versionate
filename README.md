# Versionate

## Installation

```bash
$ gem install versionate
```

## Usage

Run the following command in a directory that has a Gemfile, and it will
automatically lock it to the latest version of that gem. 

```bash
$ versionate
```

If, for some odd reason, your Gemfile is called something other than “Gemfile”,
you can specify the name as an argument to the sub-command `version`, like this:

```bash
$ versionate version file_with_gems.rb
```

### Options

You can tweak the output of versionate by passing in some options to the
command. First off, it's simple to strip off the patch versions in the resulting
versions by passing in the `--no-patch` flag:

```bash
$ versionate --no-patch
```

Prepending a version specifier to the version is simple as well, just pass it in
to the `--specifier` option:

```bash
$ versionate --specifier="~>"
```

Of course, this also works when using the more verbose syntax:

```bash
$ versionate version --no-patch --specifier="~>" Gemfile
```

### Getting help

If you find yourself forgetting commands and/or options the `help` sub-command
is always available for you:

```bash
$ versionate help
Commands:
  versionate help [COMMAND]      # Describe available commands or one specific command
  versionate process [FILENAME]  # Processes a given file (default: Gemfile)
```

You can also ask for help on specific sub-command:

```bash
$ versionate help process
Usage:
  versionate process [FILENAME]

Options:
  [--patch], [--no-patch]  # Whether or not to keep patch version (default: true)
  [--specifier=SPECIFIER]  # Specifier to be prepended to version

Processes a given file (default: Gemfile)
```
