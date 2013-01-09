class Caprica::One
  module Deploy

    module ::Capistrano
      class Configuration
        module Namespaces
          class Namespace

            def puts content
              @caprica = Caprica.active_instance
              return super unless @caprica

              if content.include? 'The following dependencies failed.'
                @caprica.six.error notice: 'failed dependencies', continue: true
              else
                content.gsub!('--> ', '')
                @caprica.logger.puts msg: content, length: false, styling: :white, dots: false, prefix: ["\u279E".red, '   ']
              end
            end

          end
        end
      end
    end
  end
end
