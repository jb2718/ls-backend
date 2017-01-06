require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "pry"
require "redcarpet"

configure do
  set :session_secret, 'secret sauce'
  enable :sessions
  set :erb, :escape_html => true
end

before do
	@files = []
	Dir["data/*"].each do |string|
		@files << string.gsub!('data/', '')
	end
end

def format_file_data(filename)
	path = "data/" + filename
	content = File.open(path)
	formatted_data = ''

	extension = filename.split('.')[1]
	if extension == "md"
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
		headers["Content-Type"] = "text/html"
		formatted_data = markdown.render(content.read)
	else
		headers["Content-Type"] = "text/plain"
		formatted_data = content.read
	end
	formatted_data
end

get "/?" do	
	erb :index
end

get "/:filename" do
	file_name = params[:filename]
	format_file_data(file_name)
	
	if @files.include? file_name
		format_file_data(file_name)
	else
		session[:error] = "#{file_name} does not exist."
		redirect '/'
	end
end