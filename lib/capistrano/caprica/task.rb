class Caprica::Task

  def initialize(current_task)
    @cap_task = current_task
    @success = false
    @failure = false
  end

  def current
    @cap_task
  end

  def description
    @cap_task.brief_description
  end

  def internal?
    description.include?('[internal]')
  end

  def failed!
    @success = false  && @success.freeze
    @failure = true   && @failure.freeze
  end

  def failed?
    @failed && ! @success
  end

  def success!
    @success = true   && @success.freeze
    @failure = false  && @failure.freeze
  end

  def success?
    @success && ! @failed
  end

end
