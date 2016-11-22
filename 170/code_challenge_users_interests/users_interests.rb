require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

before do
	@users = YAML.load_file('data/users.yaml')
end

get '/?' do
	@title = "Users"
	@names = @users.keys.map(&:to_s)
	p @names

	erb :index
end

get '/:name' do
	@user_name = params[:name].to_sym
	@user_email = @users[@user_name][:email]
	@user_interests = @users[@user_name][:interests]
	@title = "#{@user_name}'s Profile"

	erb :user
end