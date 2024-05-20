require 'socket'
require './command/command'
require './model/models'
require_relative 'invoker'

class Server
  def initialize(ip, port)
    @server = TCPServer.new(ip, port)
    @invoker = Invoker.new
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
      process_serial(client)
    end
  end

  def process_message(message)
    if message['is_command']
      command = process_command(message)
      command_name = command['command']
      args = command['args']

      execute_command(command_name, message, args)
      return
    end
    puts message['text']
  end

  def process_serial(client)
    serial = ''

    while char = client.gets
      serial << char
      if serial.include? "\x17"
        message = Marshal.load(serial)
        serial = ''

        process_message(message)
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
    begin
      @invoker.commands[command_name].execute(message, args)
    rescue NoMethodError => e
      puts 'Comando invalido'
    end
  end
end

server = Server.new('10.1.1.21', 3001)
server.start
