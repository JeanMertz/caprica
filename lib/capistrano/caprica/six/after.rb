class Caprica::Six
  module After

    def after
      successful unless @caprica.task.failed? || @caprica.silenced?

      # don't show any more output for this task after completion
      @caprica.silence!
    end

    def successful
      @caprica.task.success!
      @caprica.spinner.stop
      @caprica.logger.puts styling: :green, clear_line: true, status: :done
    end

  end
end
