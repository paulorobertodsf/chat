require 'socket'
require 'json'
require './commands/connect.rb'

server = TCPServer.new '10.1.1.21', 3001

loop do
  client = server.accept

  Thread.new do
    puts "#{client.peeraddr[2]} conectado."
    while line = client.gets
      puts line
    end
  end
end

client.close
server.close
