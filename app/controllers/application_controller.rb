require_relative '../../config/environment'
include ERB::Util
#this is a module to help sanitize for XSS- extends the controller classes to "include" those sk

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "zounds"
  end

  get '/' do
    erb :index
  end

   helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end