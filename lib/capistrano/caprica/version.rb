class Caprica
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 1
    PRE   = 'alpha'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
