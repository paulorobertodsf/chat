require 'socket'
require 'json'
require './model/message.rb'
require './model/user.rb'
IP_ADDRESS = '10.1.1.21'

client = TCPSocket.new IP_ADDRESS, 3001
user = User.new IP_ADDRESS, 'Teste'

thread_send = Thread.new do
  loop do
    msg = gets.chomp
    msg = Message.new msg, user, '0'

    client.puts(msg.getmessage)
  end
end

thread_recive = Thread.new do
  loop do
    line = client.gets
    puts line
  end
end

thread_recive.join
thread_send.join

client.close
