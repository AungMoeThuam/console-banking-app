require 'socket'
require "json"
require_relative './controllers/app_controller'
class Client
  def initialize
    @client = TCPSocket.new('localhost', 2000)
    @app = App.new
  end

  def run
    begin
      puts "Connecting the server..."
      # sleep(5)
      response = @client.gets.chomp.to_i

      if response == 1
        loop do
          @app.run_app(@client)
          print "Enter a email: "
          email = gets.chomp  # Blocked waiting for user input
          print "Enter a password: "
          password = gets.chomp
          login_credentials = {"email"=>email, "password"=>password}
          login = login_credentials.to_json
          @client.puts login   # Send the message to the server

          response = @client.gets.chomp  # Blocked waiting for server response

          puts response
        end

        @client.close
      else
        puts "server is busy"
      end

    rescue Interrupt
      puts "exit"
    rescue Errno::ECONNREFUSED
      puts "server is busy!"
    end
  end

end

client = Client.new
client.run

