require 'socket'
require './model/models'


class Client
  def initialize(ip, port, username)
    @client = TCPSocket.new(ip, port)
    @user = User.new(ip, username)
  end

  public
  def start
    start_threads
  end

  private
  def start_threads
    recive = recive_thread
    send = send_thread

    recive.join
    send.join
  end

  def send_thread
    send = Thread.new do
      loop do
        message = gets.chomp
        message = Message.new(message, @user, '0')
        message_serial = Marshal.dump(message.get_message)
        puts message_serial
        @client.puts(message_serial + '\0')
      end
    end
    return send
  end

  def recive_thread
    recive = Thread.new do
      loop do
        line = @client.gets
        puts line
      end
    end
    return recive
  end
end

client = Client.new '10.1.1.21', 3001, 'Teste'
client.start
