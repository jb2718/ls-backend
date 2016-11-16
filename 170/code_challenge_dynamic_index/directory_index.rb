require "sinatra"
require "sinatra/reloader"

file_routes = []

before do
    @files = []
    
    Dir["public/*"].each do |string|
        @files << string.gsub!('public/', '')
    end
    
    @files.each do |file|
        file_routes << '/' + file.split('.').first
    end
end

["/?", "/:order"].each do |route|
    get route do
        @title = "Dynamic Directory Index"
        order = params[:order] ? params[:order] : nil
        
        if order && order.downcase == 'ztoa'
            @files.sort! { |x,y| y <=> x }
        else
            @files.sort!
        end
        
        erb :main
    end
end


file_routes.each do |route|
    get route do
        
    end
end
