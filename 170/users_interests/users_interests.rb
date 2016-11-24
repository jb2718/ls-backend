require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

before do
	@users = YAML.load_file('data/users.yaml')
	@names = @users.keys.map(&:to_s)
end

get '/?' do
	@title = "Users"

	erb :index
end

get '/:name' do
	@user_name = params[:name].to_sym
	@user_email = @users[@user_name][:email]
	@user_interests = @users[@user_name][:interests]
	@title = "#{@user_name}'s Profile"

	erb :user
end

get '/add/user' do
	@title = "Add User"

	erb :add_user
end