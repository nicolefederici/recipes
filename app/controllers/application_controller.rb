
require_relative '../../config/environment'
require 'sinatra/base'
require 'sinatra/flash'
include ERB::Util
#this is a module to help sanitize for XSS- extends the controller classes to "include" those sk

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "zounds"
  end
  
  register Sinatra::Flash   

#I put the slash route in the application controller because it has no loyalties. One has to start here.
  
  get '/' do
    if logged_in?
      redirect to '/recipes'
    else
      redirect to '/login'
    end
  end

#if the database resided on a different system from my application, rather than a local storage type thing like I have here, with my old method for current user, I'd be communicating over the network to the other system every time it is called, which would slow the app down?

 

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end

    def logged_in?
      !!current_user
    end

    def authenticate_user 
      # if a user is not logged in redirect to '/login'
      if !logged_in?
        flash[:message] = "you must be logged in."
        redirect to '/login'
      end
    end
  end
  
end