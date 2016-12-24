require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "pry"

before do
	@files = []
	Dir["data/*"].each do |string|
		@files << string.gsub!('data/', '')
	end
end

def define_routes(files)
	file_routes = []	
	files.each do |file|
		file_routes << ('/' + file)
	end
	file_routes
end

get "/?" do
	
	erb :index
end

define_routes(@files).each do |route|
	get route do
		headers["Content-Type"] = "text/plain"
		File.read(route)
	end
end