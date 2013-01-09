class Caprica::Six
  module Error

    def error opts = {}
      @caprica.task.failed!
      @caprica.spinner.stop

      print_error opts
    end

    def print_error opts = {}
      @caprica.logger.puts styling: :red, notice: opts[:notice], clear_line: true, status: :error
      abort unless opts[:continue]
    end

  end
end
