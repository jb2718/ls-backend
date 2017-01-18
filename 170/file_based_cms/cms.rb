require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "pry"
require "redcarpet"

VALID_FILE_TYPES = {
	#keys: file types app can process; 
	#values: full word string representation of file type
	txt: "text",
	md: "markdown"
}

configure do
  set :session_secret, 'secret sauce'
  enable :sessions
  set :erb, :escape_html => true
end

before do
	file_pattern = File.join(data_path, "*")
	@file_names = Dir[file_pattern].map do |string|
		File.basename(string)
	end
	session[:blah] = "stump logged in var"
end

def data_path
	if ENV["RACK_ENV"] == "test"
		File.expand_path("../test/data",__FILE__)
	else
		File.expand_path("../data",__FILE__)
	end
end

def create_document(name, content="")
	File.open(document_path(name),"w") do |file|
		file.write(content)
	end
end

def document_path(filename)
	File.join(data_path, filename)
end

def retrieve_content(filename)
	File.open(document_path(filename))
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

def format_file_size(size)
	case 
	when (0...2**10).cover?(size)
		"#{size} bytes"
	when (2**10...2**20).cover?(size)
		"#{'%.2f' % (Float(size)/2**10)} KB"
	when (2**20...2**30).cover?(size)
		"#{'%.2f' % (Float(size)/2**20)} MB"
	when (2**30...2**40).cover?(size)
		"#{'%.2f' % (Float(size)/2**30)} GB"
	else
		"> TB"
	end
end

def expand_document_type(filename)
	type = filename.split(".")[1].to_sym
	if VALID_FILE_TYPES.has_key?(type)
		VALID_FILE_TYPES[type]
	else
		"Invalid File Type"
	end
end

class Document
end

get "/?" do
	@file_data = {}
	@file_names.each do |file_name|
		size = File.size(document_path(file_name))
		@file_data[file_name] = {
			size: format_file_size(size),
			type: expand_document_type(file_name)
		}
	end
	erb :index, layout: :layout
end

get "/:filename" do
	file_name = params[:filename]

	if @file_names.include? file_name
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
  path = File.join(data_path, @file_name)
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

#Render the new file page
get "/file/new" do
	erb :new_document
end

#Create new file page
post "/file/new" do
	file_name = params[:file_name]
	puts file_name
	create_document(file_name)
	@file_names << (file_name)
	session[:success] = "#{file_name} has been created."
	redirect "/"
end