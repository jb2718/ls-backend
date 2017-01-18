ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "pry"
require "minitest/reporters"
require "fileutils"
Minitest::Reporters.use!

require_relative "../cms"



def create_document(name, content="")
	File.open(document_path(name),"w") do |file|
		file.write(content)
	end
end


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

	def test_index
		create_document("about.txt")
		create_document("test.md")
		get "/"
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "about.txt"
		assert_includes last_response.body, "test.md"
	end

	def test_view_about
		create_document("about.txt", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla.")
		get "/about.txt"
		assert_equal 200, last_response.status
		assert_equal "text/plain", last_response["Content-Type"]
		assert_includes last_response.body, "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
	end

	def test_view_nonexistant_document
		get "/nonexistant.txt"
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
		assert_includes last_response.body, "nonexistant.txt does not exist."
	end

	def test_view_markdown_document
		test_content = "# Aristas posset
			## Fit prodidit lateantque recessu proxima cum
			Lorem markdownum illum scelerisque comes; constitit sine Phoebus hanc ab genus"
		
		create_document("test.md", test_content)
		get "/test.md"
		assert_equal 200, last_response.status
		assert_equal "text/html", last_response["Content-Type"]
		assert_includes last_response.body, "<h1>Aristas posset</h1>"
	end

	def test_edit_document_plaintext
		create_document("about.txt")
		get "/about.txt/edit"
		assert_equal 200, last_response.status
	end

	def test_new_document
		get "/file/new"
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "Create New Document"
	end

	def test_new_document_create_button
		post "file/new", "new_doc.txt"
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
		assert_includes last_response.body, "text.txt has been created"
	end

	def test_new_document_error
		post "file/new", ".txt"
		assert_equal 422, last_response.status
		assert_includes last_response.body, "A file name is required"
	end
end