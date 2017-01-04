require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "pry"
# require "redcarpet"

configure do
  set :session_secret, 'secret sauce'
  enable :sessions
  # set :erb, :escape_html => true
end

before do
	@files = []
	Dir["data/*"].each do |string|
		@files << string.gsub!('data/', '')
	end
end

get "/?" do	
	erb :index
end

get "/:filename" do
	file_name = params[:filename]
	
	if @files.include? file_name
		path = "data/" + file_name
		headers["Content-Type"] = "text/plain"
		text = File.open(path)
		text.read
	else
		session[:error] = "#{file_name} does not exist."
		redirect '/'
	end
end