require 'socket'

server = TCPServer.new("localhost", 3003)

loop do
	client = server.accept

	# Reads in first line of request 
	# text (the GET '/'...etc part)
	request_line = client.gets
	
	# Here are the echoes - first on console, 
	# then on web browser
	puts request_line
	client.puts request_line

	client.close
end