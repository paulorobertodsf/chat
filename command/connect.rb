require './model/link'
require_relative 'command'

class Connect < Command
  def execute(message, args)
    user = message['author'].username
    puts user
  end
end
