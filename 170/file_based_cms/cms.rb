libs = %w(sinatra sinatra/reloader sinatra/content_for tilt/erubis pry)
libs.each  { |lib| require lib}
require_relative 'document'


configure do
  set :session_secret, 'secret sauce'
  enable :sessions
  set :erb, :escape_html => true
end

before do
	@documents = []
	if !load_file_data.empty?
		@documents = load_file_data
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

def load_file_data
	documents = []
	file_pattern = File.join(data_path, "*")
	Dir[file_pattern].each do |string|
		file_name = File.basename(string)
		path = File.dirname(string)
		documents << Document.new
		documents.last.load(file_name, path)
	end
	documents
end

def find_by_name(filename)
	same_names = @documents.reject do |document|
		document.name.downcase != filename.downcase
	end
	same_names.first
end

#Return error if doc name has error, otherwise return nil
def error_for_new_doc_name(filename, extension)
	full_file_name = filename + "." + extension
  if !(1..20).cover?(filename.size)
    return "File name must be between 1 and 20 characters"
  elsif find_by_name(full_file_name)
    return "File name must be unique"
	end
	nil
end

get "/?" do
	erb :index, layout: :layout
end

#View file content
get "/:filename" do
	document = find_by_name(params[:filename])
	if document
		headers["Content-Type"] = document.format_content[:headers][:content_type]
		document.format_content[:body]
	else
		session[:error] = "#{file_name} does not exist."
		redirect '/'
	end
end

#Render the edit file page
get "/:filename/edit" do
	@document = find_by_name(params[:filename])
	erb :edit_document
end

# # Update/edit page information
# post "/:filename" do
#   @file_name = params[:filename]
#   path = File.join(data_path, @file_name)
#   file = open(path,'w')
#   content = params[:file_content]
#   file.write(content)
#   file.close
#   session[:success] = "#{@file_name} has been updated."
#   redirect "/"

#   # error = error_for_list_name(list_name)
#   # if error
#   #   session[:error] = error
#   #   erb :edit_list, layout: :layout
#   # else
#   #   session[:success] = "#{@file_name} has been updated."
#   #   redirect "/"
#   # end
# end

#Render the new file page
get "/file/new" do
	@valid_file_types = Document::VALID_FILE_TYPES
	erb :new_document, layout: :layout
end

#Create new file page
post "/file/new" do
	@valid_file_types = Document::VALID_FILE_TYPES
	file_name_base = params[:doc_name].strip
	extension = params[:file_type]

	error = error_for_new_doc_name(file_name_base, extension)
	
	if error
		session[:error] = error
    erb :new_document, layout: :layout
	else
		file_name = file_name_base.strip + "." + extension		
		@documents << Document.new
		@documents.last.create_document(file_name, data_path)
		session[:success] = "#{file_name} has been created."
		redirect "/"
	end
end

#Delete a file
post "/:filename/delete" do
	filename = params[:filename]
	doc = find_by_name(filename)

	doc.delete_file
	@documents.delete(doc)
	session[:success] = "#{filename} was deleted"
	redirect "/"
end