class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/recipes'
    end
  end

  post '/signup' do
    if !logged_in?
      @user = User.new(params)
      if @user.save
        session[:user_id] = @user.id
        redirect to '/recipes'
      else 
        redirect to '/signup'
      end
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/recipes'
    end
  end

#authenticate is bcrypt method, not active record, remember. 
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/recipes'
    else 
      redirect to '/signup'
    end
  end

  get '/users/:slug/show' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


  get '/logout' do
    if logged_in? 
      session.destroy
      redirect to '/login'
    else
      redirect to '/login'
    end
  end
end