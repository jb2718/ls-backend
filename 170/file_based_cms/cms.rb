require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"

get "/?" do
	"Getting started."
end