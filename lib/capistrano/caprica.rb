class Caprica
  require 'pp'
  require 'capistrano/caprica/version'
  require 'capistrano/caprica/task'
  require 'capistrano/caprica/one'
  # require 'caprica/three'
  require 'capistrano/caprica/six'

  require 'colored'


  attr_reader :task, :logger, :spinner, :one, :six

  @@active_instance = nil
  @verbose = true if ARGV.any? { |v| v =~ /-[v]{2,}/ }

  def initialize task
    @task     = Caprica::Task.new(task)
    @logger   = Caprica::Six::Logger.new(self)
    @spinner  = Caprica::Six::Spinner.new(self)
    @silence  = false

    @@active_instance = self

    # activate cylons
    @one = Caprica::One.new(self) if defined? Caprica::One
    @six = Caprica::Six.new(self) if defined? Caprica::Six
  end

  def self.active_instance
    @@active_instance
  end

  def before
    @six.before if defined? @six
  end

  def after
    @six.after if defined? @six
  end

  def silence!
    @silence = true
  end

  def silenced?
    @silence
  end

  def self.verbose
    @verbose ? true : false
  end

  def self.verbose= value
    @verbose = value
  end
end

Capistrano::Configuration.instance(true).load do
  @skip_carpica = true if ARGV.include? '-v'

  next if @skip_carpica

  on :before do
    @caprica = Caprica.new(current_task)
    @caprica.before
  end

  on :after do
    @caprica.after
  end
end


class Array
  def inject(n)
     each { |value| n = yield(n, value) }
     n
  end

  def rsend(baseobj)
    inject(baseobj) { |n, value| n.send(value) }
  end
end
