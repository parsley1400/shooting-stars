require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
  if current_user.nil?
    @counts = Count.none
  else
    @counts = Count.all
    @name = current_user.username
  end
  erb :index
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
  @user = User.create(username: params[:username],image: params[:image], password: params[:password], password_confirmation: params[:password_confirmation])
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/signup'
end

get '/new' do
  erb :new
end

post '/new' do
  current_user.counts.create(name: params[:name], image: params[:image])
  redirect '/'
end

post '/counts/:id/add' do
  count = Count.find(params[:id])
  count.number = count.number + 1
  count.save
  redirect '/'
end

get '/user/:id' do
  @image = current_user.image
  @name = current_user.username
  @counts = Count.all
  @usercounts = UserCount.where(user_id_id: session[:user])
  erb :user
end

get '/counts/:id' do
  @count = Count.find(params[:id])
  @users = User.all
  @countusers = UserCount.where(count_id_id:params[:id])
  erb :detail
end

post '/counts_detail/:id/add' do
  count = Count.find(params[:id])
  count.number = count.number + 1
  count.save
  redirect "/counts/#{count.id}"
end