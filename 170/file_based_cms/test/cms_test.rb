ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "pry"
require "minitest/reporters"
require "fileutils"
Minitest::Reporters.use!

require_relative "../cms"


class CMSTest < Minitest::Test
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def setup
		FileUtils.mkdir_p(data_path)
	end

	def teardown
		FileUtils.rm_rf(data_path)
	end

	def session
		last_request.env["rack.session"]
	end

	def login
		post "/users/signin", username: "admin", password: "test"
	end

	def user_signed_in
		{"rack.session" => { username: "admin", logged_in: true}}
	end

	def test_index
		Document.new.create_document("about.txt", data_path)
		Document.new.create_document("test.md", data_path)
		get "/"
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "about.txt"
		assert_includes last_response.body, "test.md"
	end

	def test_view_about
		doc = Document.new
		doc.create_document("about.txt", data_path)
		doc.update_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla.")
		get "/about.txt"
		assert_equal 200, last_response.status
		assert_equal "text/plain", last_response["Content-Type"]
		assert_includes last_response.body, "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
	end

	def test_view_nonexistant_document
		get "/nonexistant.txt"
		assert_equal 302, last_response.status
		assert_equal "nonexistant.txt does not exist.", session[:error]
	end

	def test_view_markdown_document
		test_content = "# Aristas posset
			## Fit prodidit lateantque recessu proxima cum
			Lorem markdownum illum scelerisque comes; constitit sine Phoebus hanc ab genus"
		doc = Document.new
		doc.create_document("test.md", data_path)
		doc.update_content(test_content)
		get "/test.md"
		assert_equal 200, last_response.status
		assert_equal "text/html", last_response["Content-Type"]
		assert_includes last_response.body, "<h1>Aristas posset</h1>"
	end

	def test_edit_document_plaintext
		Document.new.create_document("about.txt", data_path)	
		get "/about.txt/edit",{}, user_signed_in
		assert_equal 200, last_response.status
	end

	def test_edit_document_update_content
		Document.new.create_document("trix.txt", data_path)	
		post "/trix.txt/edit", {file_content: "Silly rabbit, trix are for kids"}, user_signed_in

		assert_equal 302, last_response.status
		assert_equal "trix.txt has been updated.", session[:success]
		
		get "/trix.txt"
		assert_equal 200, last_response.status
		assert_equal "text/plain", last_response["Content-Type"]
		assert_includes last_response.body, "Silly rabbit, trix are for kids"
	end

	def test_edit_document_update_logged_out
		Document.new.create_document("trix.txt", data_path)	
		post "/trix.txt/edit", {file_content: "Silly rabbit, trix are for kids"}
		assert_equal "You must be signed in to do that", session[:error]
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
	end

	def test_new_document
		get "/file/new", {}, user_signed_in
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "Create New Document"
	end

	def test_new_document_create
		post "file/new", {doc_name: "new_doc", file_type: "txt"}, user_signed_in
		assert_equal 302, last_response.status
		assert_equal "new_doc.txt has been created.", session[:success]

		get last_response["Location"]
		assert_equal 200, last_response.status
		assert_includes last_response.body, "new_doc.txt"
	end

	def test_new_document_error
		post "file/new", {doc_name: "", file_type: "txt"}, user_signed_in
		assert_equal 422, last_response.status
		assert_includes last_response.body, "File name must be between 1 and 20 characters"
	end

	def test_new_document_create_logged_out
		post "file/new", {doc_name: "new_doc", file_type: "txt"}
		assert_equal "You must be signed in to do that", session[:error]
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
	end

	def test_delete_document
		Document.new.create_document("to_delete.txt", data_path)	
		post "/to_delete.txt/delete", {}, user_signed_in
		assert_equal 302, last_response.status
		assert_equal "to_delete.txt was deleted", session[:success]

		get last_response["Location"]
		assert_equal 200, last_response.status
	end

	def test_delete_logged_out
		Document.new.create_document("to_delete.txt", data_path)	
		post "/to_delete.txt/delete"
		assert_equal "You must be signed in to do that", session[:error]
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
	end

	def test_login_form
		get '/users/signin'
		assert_equal 200, last_response.status

		assert_includes last_response.body, "Username"
		assert_includes last_response.body, "Password"
		assert_includes last_response.body, "Sign In"
	end

	def test_login
		post '/users/signin', {username: "admin", password: "test"}
		assert_equal "Welcome!", session[:success]
		assert_equal true, session[:logged_in]
		assert_equal "admin", session[:username]
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
	end

	def test_login_invalid
		post '/users/signin', {username: "wrong", password: "bad"}
		assert_includes last_response.body, "Invalid Credentials"
	end

	def test_logout
		post 'users/signout'
		assert_equal false, session[:logged_in]
		assert_equal nil, session[:username]
		assert_equal "You have been signed out", session[:success]
	end
end