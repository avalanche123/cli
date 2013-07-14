module CLI
  class Application
    def initialize(name, version)
      @name         = name
      @version      = version
      @commands     = {}
      @opts         = OptionParser.new

      @opts.program_name = @name

      @opts.banner = "Usage: #{@name} [--version] [--help] command [options] [args]"

      @opts.top.append("", nil, nil)
      @opts.top.append("Available #{@name} commands are:", nil, nil)

      @opts.base.append("", nil, nil)
      @opts.base.append("Common options:", nil, nil)

      @opts.on_tail("-h", "--help",    "Show this message") { print_help    }
      @opts.on_tail('-v', '--version', "Show version")      { print_version }
    end

    def command(usage, description, options, handler)
      parts   = usage.split(" ")
      command = parts.shift

      @opts.separator(sprintf("  %-10.10s %s", command, description))

      parts.unshift("#{@name}-#{command}")

      @commands[command] = Command.new(parts.join(" "), options, handler)
    end

    def run(argv)
      if argv.empty?
        print_help
      end

      command = @commands[argv.first]

      if command.nil?
        @opts.permute!(argv)
        print_help
      else
        argv.shift
        command.run(argv)
      end
    rescue OptionParser::InvalidOption => e
      @opts.warn(e.message)
      print_help
    rescue Interrupt
      exit 0
    rescue => e
      @opts.abort(e.message)
    end

    def to_proc
      proc { |opts, args| run(args) }
    end

    private

    def print_help
      puts @opts
      exit 1
    end

    def print_version
      puts "#{@name} #{@version}"
      exit 0
    end
  end
end
