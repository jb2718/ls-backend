require 'sinatra'
require 'sinatra/reloader' if development?
require 'yaml'

def joinor(list, token=',', word='or')
  tail = list.last
  if list.count > 2
    head = list[0..-2]
    head.join(token) + "#{token}#{word} #{tail}"
  elsif list.count == 2
    list.first.to_s + " #{word} #{tail}"
  else
    tail.to_s
  end
end

def count_interests(yaml_data)
	names = yaml_data.keys.map(&:to_s)
	interest_count = 0
	names.each do |key|
		interest_count += yaml_data[key.to_sym][:interests].count
	end
	interest_count
end

before do
	@data = YAML.load_file('data/users.yaml')
	@names = @data.keys.map(&:to_s)
	@user_count = @names.count
	@interest_count = count_interests(@data)
end

helpers do
	def menu_list
		display_list = Array.new(@names)
		display_list.delete(params[:name]) if params[:name]
		display_list
	end
end

get "/?" do
  @title = "Users"
  @user_list = Array.new(@names)
  
  erb :index
end

get '/:name' do
	@user_name = params[:name].to_sym
	@user_email = @data[@user_name][:email]
	@user_interests = @data[@user_name][:interests]
	@formatted_interests = joinor(@user_interests, ', ', 'and')
	@title = "#{@user_name}'s Profile"

	erb :user
end

get '/add/user' do
	@title = "Add User"

	erb :add_user
end