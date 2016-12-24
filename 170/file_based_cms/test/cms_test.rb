ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../cms"

class CMSTest < Minitest::test
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_index
	end
end