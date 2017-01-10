ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "pry"

require_relative "../cms"

class CMSTest < Minitest::Test
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_index
		get "/"
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "about.txt"
		assert_includes last_response.body, "changes.txt"
		assert_includes last_response.body, "history.txt"
	end

	def test_view_about
		get "/about.txt"
		assert_equal 200, last_response.status
		assert_equal "text/plain", last_response["Content-Type"]
		assert_includes last_response.body, "Class aptent taciti sociosqu ad litora torquent"
	end

	def test_view_nonexistant_document
		get "/nonexistant.txt"
		assert_equal 302, last_response.status

		get last_response["Location"]
		assert_equal 200, last_response.status
		assert_includes last_response.body, "nonexistant.txt does not exist."
	end

	def test_view_markdown_document
		get "/test.md"
		assert_equal 200, last_response.status
		assert_equal "text/html", last_response["Content-Type"]
		assert_includes last_response.body, "<h1>Aristas posset</h1>"
	end

	def test_edit_document_plaintext
		get "/about.txt/edit"
		assert_equal 200, last_response.status
	end
end