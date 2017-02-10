require 'sinatra/flash'

class Recipe <ActiveRecord::Base
  belongs_to :user
  
  validates :title, :ingredients, :directions, presence: {message: "must not be left blank."}

end