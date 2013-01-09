class Caprica::Six
  class Logger

    attr_accessor :notice

    def initialize(caprica)
      @caprica = caprica
    end

    def print opts = {}
      ::Kernel.print(parser opts)
    end

    def puts opts = {}
      ::Kernel.puts(parser opts)
    end

    def string opts = {}
      parser opts
    end

    def parser opts = {}
      opts = {
        length:     terminal_width/2.3,       # [False, Integer]
        styling:    [],                       # [Array, :red, :green, :blue, :bold, etc...]
        clear_line: false,                    # [False, True]
        prefix:     ["\u279E".white, '   '],  # [False, String, Array]
        dots:       true,                     # [True, False]
        status:     nil,                      # [False, String, :done, :error, :skipped]
        notice:     nil,                      # [False, String]
        append:     nil                       # [Nill, String]
      }.merge(opts)

      msg = opts.fetch(:msg, @caprica.task.description.strip)
      msg = msg[0, opts[:length]] if opts[:length]
      dots_width  = terminal_width/2 - msg.length

      m =   []
      m <<  ["\r","\e[K"]                         if opts[:clear_line]
      m <<  [opts[:prefix]]                       if opts[:prefix]
      m <<  [[opts[:styling]].flatten.rsend(msg)]
      m <<  [' ', ('.' * dots_width).black]       if opts[:dots]
      m <<  [' ', "\u2713".green]                 if opts[:status] == :done
      m <<  [' ', "\u2718".red]                   if opts[:status] == :error
      m <<  [' ', "\u273B".yellow]                if opts[:status] == :skipped
      m <<  [' ', opts[:status].yellow]           if opts[:status].is_a? String
      m <<  [' ', opts[:notice].black]            if opts[:notice]
      m <<  [opts[:append]]                       if opts[:append]

      m.flatten.join('')
    end

    private

    def terminal_width
      `stty size | cut -d' ' -f2`.to_i
    end
  end
end
