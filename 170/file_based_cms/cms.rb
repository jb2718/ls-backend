libs = %w(sinatra sinatra/reloader sinatra/content_for tilt/erubis pry yaml bcrypt)
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
end

def load_accounts
  if ENV["RACK_ENV"] == "test"
    path = File.expand_path("../test/test_user_accounts.yml",__FILE__)
  else
    path = File.expand_path("../user_accounts.yml",__FILE__)
  end
  YAML.load_file(path)
end

ACCOUNTS = load_accounts

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
  elsif (filename =~ /(^[A-Za-z][A-Za-z0-9_]+)$/).nil?
    return "Invalid file name.  File must begin with an alpha character.  The rest of the file name can only contain alphanumeric characters and underscores"
  end
  nil
end

def signed_in?
  session[:logged_in]
end

def require_sign_in
  if !signed_in?
    session[:error] = "You must be signed in to do that"
    redirect "/"
  end
end

def valid_login?(username, password)
  return ACCOUNTS.has_key?(username) && BCrypt::Password.new(ACCOUNTS[username]) == password
end

get "/users/signin" do
  erb :sign_in, layout: :layout
end

post "/users/signin" do
  @username = params[:username]
  password = params[:password]
  if valid_login?(@username,password)
    session[:username] = @username
    session[:logged_in] = true
    session[:success] = "Welcome!"
    redirect "/"
  else
    session[:error] = "Invalid Credentials"
    @username = params[:username]
    erb :sign_in, layout: :layout
  end
end

#log user out
post "/users/signout" do
  session[:username] = nil
  session[:logged_in] = false
  session[:success] = "You have been signed out"
  redirect "/"
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
    session[:error] = "#{params[:filename]} does not exist."
    redirect '/'
  end
end

#Render the edit file page
get "/:filename/edit" do
  require_sign_in
  @document = find_by_name(params[:filename])
  erb :edit_document
end

# # Update/edit page information
post "/:filename/edit" do
  require_sign_in
  @document = find_by_name(params[:filename])
  @document.update_content(params[:file_content])
  session[:success] = "#{params[:filename]} has been updated."
  redirect "/"
end

#Render the new file page
get "/file/new" do
  require_sign_in
  @valid_file_types = Document::VALID_FILE_TYPES
  erb :new_document, layout: :layout
end

#Create new file page
post "/file/new" do
  require_sign_in
  @valid_file_types = Document::VALID_FILE_TYPES
  @file_name_base = params[:doc_name].strip
  extension = params[:file_type]

  error = error_for_new_doc_name(@file_name_base, extension)
  
  if error
    session[:error] = error
    status 422
    @file_name_base
    erb :new_document, layout: :layout
  else
    file_name = @file_name_base.strip + "." + extension   
    @documents << Document.new
    @documents.last.create_document(file_name, data_path)
    session[:success] = "#{file_name} has been created."
    redirect "/"
  end
end

#Delete a file
post "/:filename/delete" do
  require_sign_in
  filename = params[:filename]
  doc = find_by_name(filename)

  doc.delete_file
  @documents.delete(doc)
  session[:success] = "#{filename} was deleted"
  redirect "/"
end