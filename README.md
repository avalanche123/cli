# CLI

A small command line interface library for quickly building cli apps.

## Usage

Add this to your Gemfile:

    gem 'avalanche-cli', :git => 'git://github.com/avalanche123/cli.git'

Build a single command script:


```ruby
#!/usr/bin/env ruby

require 'bundler/setup'
require 'avalanche/cli'

cmd = Avalanche::CLI::Command.new('hello [options] NAME', {
  :title => ['--title TITLE', String, 'Desired title']
}, Proc.new do |opts, args|
  raise "NAME is required" if args.empty?

  puts "Hello, #{opts[:title]} #{args.first}!".gsub(/\s+/, " ")
end)

cmd.run(ARGV)
```

Build a cli application with many subcommands:

```ruby
#!/usr/bin/env ruby

require 'bundler/setup'
require 'avalanche/cli'

app = Avalanche::CLI::Application.new('app', '0.1.0')

app.command('hello [options] NAME', "Says Hello", {
  :title => ['--title TITLE', String, 'Desired title']
}, Proc.new do |opts, args|
  raise "NAME is required" if args.empty?

  puts "Hello, #{opts[:title]} #{args.first}!".gsub(/\s+/, " ")
end)

app.run(ARGV)
```

Check it:

```shell
> /path/to/command --help
```

## License

MIT
