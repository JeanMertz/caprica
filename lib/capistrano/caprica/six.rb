require 'capistrano/caprica/six/before'
require 'capistrano/caprica/six/after'
require 'capistrano/caprica/six/logger'
require 'capistrano/caprica/six/spinner'
require 'capistrano/caprica/six/error.rb'
# require 'caprica/six/prettify.rb'
# require 'caprica/six/callbacks.rb'
# require 'caprica/six/notify.rb'
# require 'caprica/six/skip.rb'
# require 'caprica/six/succeed.rb'

class Caprica::Six
  include Caprica::Six::Before
  include Caprica::Six::After
  include Caprica::Six::Error

  def initialize caprica
    @caprica = caprica
  end
end
