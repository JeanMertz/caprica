# module Caprica
#   module Six
#     module Callbacks

#       def initialize
#         @hide_task_output         = false
#         @tasks_without_callbacks  = ['nginx:setup']
#       end

#       def before
#         Capistrano::Configuration.instance.load do
#           on :before, except: tasks_without_callbacks do
#             Caprica::Six.start(current_task)
#           end

#           on :after, except: tasks_without_callbacks do
#             Caprica::Six.finish(current_task) if show_output?
#           end

#           def internal_task?
#             current_task.desc.include?('[internal]')
#           end
#         end

#       end

#       def after
#         Capistrano::Configuration.instance.load do
#           on :after, except: tasks_without_callbacks do
#             Caprica::Six.succeed if show_output?
#           end
#         end
#       end


#       Capistrano::Configuration.instance.load do
#         on :before, except: tasks_without_callbacks do
#           Caprica::Six::Callbacks.start
#           return hide_task_output if internal_task?

#           @description = current_task.desc

#           pprint styling: :white, trailing_whitespace: true
#           spinner :start
#         end

#         on :after, except: tasks_without_callbacks do
#           Caprica::Six.succeed if show_output?
#         end

#         def internal_task?
#           current_task.desc.include?('[internal]')
#         end
#       end

#       private

#       def show_output?
#         !! @hide_task_output
#       end

#       def tasks_without_callbacks
#         @tasks_without_callbacks
#       end

#     end
#   end
# end


# Capistrano::Configuration.instance.load do
#     on :before, except: skip_callbacks do
#     unset :cap_task_unsuccessful
#     @hide_task_output = false
#     if ! current_task.desc || current_task.desc.include?('[internal]')
#       @hide_task_output = true
#     else
#       @start_msg = current_task.desc
#       pprint @start_msg, styling: :white, trailing_whitespace: true
#       start_spinner
#     end
#   end

#   on :after, except: skip_callbacks do
#     succeeded unless @hide_task_output
#   end

# end
