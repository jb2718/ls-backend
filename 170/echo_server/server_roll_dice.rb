require "socket"

def parse_request(request_line)
  http_method = request_line.split(" ")[0]
  path_params = request_line.split(" ")[1]
  path = path_params[/.*\?/].slice(0...-1)
  params = {}
  params_str = path_params[/\?.*/].slice(1..-1)
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
  next if !request_line || request_line =~ /favicon/
  puts request_line


  http_method, path, params = parse_request(request_line)

  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params

  params["rolls"].to_i.times do
    sides = params["sides"].to_i
    client.puts rand(sides) + 1
  end
  client.close
end