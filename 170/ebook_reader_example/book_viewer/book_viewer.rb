require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "The Adventures of Sherlock Homes"
  @toc_data = File.read("data/toc.txt").split("\n")
  erb :home
end


get "/chapters/:number" do
  @num = params[:number].to_i
  @title = "Chapter " + @num.to_s
  @toc_data = File.read("data/toc.txt").split("\n")
  @chapter_data = File.read("data/chp" + @num.to_s + ".txt")
  erb :chapter
end