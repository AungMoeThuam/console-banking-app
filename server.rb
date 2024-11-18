require 'socket'
require_relative "./controllers/user_controller"
require_relative './controllers/auth_controller'
require "json"


server = TCPServer.new(2000)  # Creates a server on port 2000
puts "Server started on port 2000..."

while true
  client = server.accept       # Wait for a client to connect
  puts "Client connected."

  Thread.new do                # Handle each client in a new thread
    client.puts 1
    while true
      if client.gets == nil
        break
      end

      message = client.gets.chomp # Receive a message from the client
      message = JSON.parse(message)
      user = login(message)
      if user
        client.puts(user.to_json)
      else
        client.puts(user)
      end
      puts "Client says: #{message}"
    end

    puts "Client disconnected."
    client.close
  end
end
