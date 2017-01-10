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

def retrieve_content(filename)
	path = "data/" + filename
	File.open(path)
end

def format_file_data(filename)
	content = retrieve_content(filename)
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
	
	if @files.include? file_name
		format_file_data(file_name)
	else
		session[:error] = "#{file_name} does not exist."
		redirect '/'
	end
end

#Render the edit file page
get "/:filename/edit" do
	@file_name = params[:filename]
	@file_content = retrieve_content(@file_name)
	erb :edit_document
end

# Update/edit page information
post "/:filename" do
  @file_name = params[:filename]
  path = 'data/'+ @file_name
  file = open(path,'w')
  content = params[:file_content]
  file.write(content)
  file.close
  session[:success] = "#{@file_name} has been updated."
  redirect "/"

  # error = error_for_list_name(list_name)
  # if error
  #   session[:error] = error
  #   erb :edit_list, layout: :layout
  # else
  #   session[:success] = "#{@file_name} has been updated."
  #   redirect "/"
  # end
end