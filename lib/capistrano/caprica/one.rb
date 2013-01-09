require 'capistrano/caprica/six'
require 'capistrano/caprica/one/deploy'

class Caprica::One
  include Caprica::One::Deploy

  def initialize caprica
    @caprica = caprica
  end

  def verbose_debugger message
    msg_opts = {
      styling: :black,
      clear_line: true,
      dots: false,
      prefix: '    '
    }

    case @caprica.logger.notice
    when nil
      @caprica.spinner.stop
      @caprica.logger.puts clear_line: true, dots: false
    when /^executing ".*"/
      @caprica.logger.puts msg_opts.merge(msg: @caprica.logger.notice)
    end

    @caprica.logger.notice = message
    @caprica.logger.print msg_opts.merge(msg: message)
  end

  def inline_debugger message
    @caprica.spinner.start message
  end
end

module ::Capistrano
  class Logger

    alias_method :debug_internal, :debug
    def debug(message, line_prefix=nil)
      @caprica = Caprica.active_instance

      if ! @caprica || @caprica.silenced? || message =~ /^executing command$/
        return debug_internal(message, line_prefix)
      end

      if Caprica.verbose
        @caprica.one.verbose_debugger(message)
      else
        @caprica.one.inline_debugger(message)
      end
    end
  end
end
