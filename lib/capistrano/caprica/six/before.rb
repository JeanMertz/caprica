class Caprica::Six
  module Before

    def before
      @caprica.task.internal? && ! Caprica.verbose ? stop : start
    end

    def after
      finish unless @caprica.silenced?
    end

    def stop
      @caprica.silence!
    end

    def start
      @caprica.logger.print styling: :white, append: ' '
      @caprica.spinner.start
    end
  end
end
