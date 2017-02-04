
require_relative '../../config/environment'
require 'rack-flash'
include ERB::Util
#this is a module to help sanitize for XSS- extends the controller classes to "include" those sk

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "zounds"
  end

use Rack::Flash 

#I put the slash route in the application controller because it has no loyalties. One has to start here.
  
  get '/' do
    if logged_in?
      redirect to '/recipes'
    else
      redirect to '/login'
    end
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