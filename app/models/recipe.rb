require 'sinatra/flash'

class Recipe <ActiveRecord::Base
  belongs_to :user
  
  validates :title, :ingredients, :directions, presence: {message: "must not be left blank."}


#remember to ask Luke about this kind of activity in the models-- where did I get this?


  # after_initialize do |recipe|
  #   flash[:error] = "You have initialized a recipe!"
  # end
 
  # after_find do |recipe|
  #  flash[:error] = "You have found a recipe!"
  # end

  # after_save do |recipe|
  #    flash[:error] += "\nYou have saved a recipe!"
  # end

  # after_destroy do |recipe|
  #   flash[:error] = "You have destroyed a recipe!"
  # end
 
 
 


end