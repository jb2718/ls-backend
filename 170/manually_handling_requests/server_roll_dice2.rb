# modified to return valid http response to browser

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

  client.puts "<h1>Rolls</h1>"
  params["rolls"].to_i.times do
    sides = params["sides"].to_i
    client.puts "<p>#{rand(sides) + 1}</p>"
  end  

  
  client.puts "</body>"
  client.puts "</html>"


  client.close
end