require "socket"

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  # "GET /?rolls=2&sides=6 HTTP/1.1"

  http_method = request_line.split(" ")[0]
  path_params = request_line.split(" ")[1]
  path = path_params[/.*\?/].slice(0...-1)
  params = {}
  params_str = path_params[/\?.*/].slice(1..-1)
  params_str.split('&').each do |phrase|
    pieces = phrase.split('=')
    params[pieces.first] = pieces.last
  end

  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  client.puts rand(6) + 1

  client.close
end