     
require 'sinatra'
# require 'sinatra/reloader' # only reload the defalut file ( model files not includeded)
require 'pg'
require_relative 'db_config'
require_relative 'models/dish'
require_relative 'models/comment'
require_relative 'models/user'
require_relative 'models/like'
enable :sessions

# now dish and comment are objects, so in erb files, can use @dish.id instead of @dish['id] etc.

get '/' do
  @dishes = Dish.all
  erb :index
end

get '/about' do
end

#getting the form
get '/dishes/new' do
  erb :new
end

get '/dishes/:id' do
  @dish = Dish.find(params[:id])
  @comments = @dish.comments
  erb :dish_details
end

#create a new dish
post '/dishes' do
  dish = Dish.new
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save
  redirect '/' 
end

# delete a dish
delete '/dishes/:id' do
  dish = Dish.find(params[:id])
  dish.destroy
  redirect '/'
end
# edit dish page
get '/dishes/:id/edit' do
  @dish = Dish.find(params[:id])
  erb :edit
end

# update edit
put '/dishes/:id' do
  dish = Dish.find(params[:id])
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save
  redirect '/'
end

#comment
post "/comments" do
  redirect '/login' unless logged_in?
  comment = Comment.new
  comment.content = params[:content]
  comment.dish_id = params[:dish_id]
  comment.save
  redirect "/dishes/#{params[:dish_id]}"
end 

get '/login' do
  erb :login
end

post '/session' do
  # grab email & password
  # find the user by email
  user = User.find_by(email: params[:email])
  # authenticate user with password
  if user && user.authenticate(params[:password])
    # create new seesion
    session[:user_id] = user.id
    # rediret to secret page
    redirect '/'
  else 
    erb :login
  end
end 

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

def current_user
  User.find_by(id: session[:user_id])
end 

def logged_in?
  !!current_user
  #only false and nil are falsy in ruby
  # if current_user exsits, !current_user = false, !false = true ===> covert to boolean
end 

post '/likes' do
  redirect'/login' unless logged_in?
  

  l1 = Like.find_by(dish_id: params[:dish_id], user_id:current_user.id)
  if l1 == nil 
    like = Like.new
    like.dish_id = params[:dish_id]
    like.user_id = current_user.id
    like.save
  end
  
  redirect "/dishes/#{params[:dish_id]}"
end