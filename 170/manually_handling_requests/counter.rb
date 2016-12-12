# modified to return valid http response to browser

require "socket"

def parse_request(request_line)
  http_method, path, http = request_line.split(" ")

  path, params_str = path.split('?')
  params = {}
  params_str.split('&').each do |phrase|
    pieces = phrase.split('=')
    params[pieces.first] = pieces.last
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line.include?('?') || request_line =~ /favicon/
  puts request_line


  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"

  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"

  number = params["number"].to_i
  client.puts "<p>The number is #{number}</p>"
  client.puts "<p><a href='?number=#{number + 1}'>Increment the number</a></p>"
  client.puts "<p><a href='?number=#{number - 1}'>Decrement the number</a></p>"  
  client.puts "</body>"
  client.puts "</html>"


  client.close
end