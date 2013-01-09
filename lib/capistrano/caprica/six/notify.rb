Capistrano::Configuration.instance.load do |cap|
  def notify string
    @caprica = Caprica.active_instance
    return unless @caprica

    @caprica.logger.print notice: string, clear_line: true
  end
end
