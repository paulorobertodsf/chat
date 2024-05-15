require 'socket'
require './command/command'
require_relative 'invoker'

class Server
  def initialize(ip, port)
    @server = TCPServer.new(ip, port)
  end

  public
  def start
    loop do
      client = @server.accept
      connect_client(client)
    end
  end

  private
  def connect_client(client)
    Thread.new do
      puts "#{client.peeraddr[2]} conectado."
      process_messages(client)
    end
  end

  def process_messages(client)
    serial = ''
    while char = client.getc
      serial << char
      if serial[-2..-1] == '\0'
        
      end
    end
  end

  def process_command(message)
    command_split = message['text'].split(' ')
    command_name = command_split[0][1..-1] # pega o comando
    args = command_split[1..-1] # pega os argumentos do comando

    hash_command = {
      'command' => command_name,
      'args' => args
    }
    return hash_command
  end

  def execute_command(command_name, message, args)
    invoker = Invoker.new
    invoker.commands[command_name].execute(message, args)
  end
end

server = Server.new('10.1.1.21', 3001)
server.start


=begin
      while line = client.gets
      puts line
      message = Marshal.load(line)
      puts message
      if message['is_command']
        command = process_command(message)
        command_name = command['command']
        args = command['args']

        execute_command(command_name, message,args)
        next
      end
      puts line
    end
=end
