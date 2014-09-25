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
you can specify the name as an argument to the command, like this:

```bash
$ versionate file_with_gems.rb
```
