# encoding: utf-8
class Caprica::Six
  class Spinner

    def initialize caprica
      @caprica = caprica
      @chars = %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷]
      @running = false
    end

    def start notice = false
      stop
      @notice = notice
      @running = true
      spinner :wakeup
    end

    def stop
      @notice = false
      @running = false
      sleep 0.1
    end

    def spinner action
      Thread.new do
        loop do
          if ! @running
            Thread.stop
          end

          if @notice
            @caprica.logger.print notice: @notice, status: @chars[0].bold.yellow, clear_line: true
            sleep 0.1
          else
            print @chars[0].bold.yellow
            sleep 0.1
            print "\b"
          end
          @chars.push @chars.shift
        end
      end.send(action)
    end

  end
end
