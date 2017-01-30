class Recipe <ActiveRecord::Base
  belongs_to :user
  
  validates :title, :ingredients, :directions, presence: {message: "oops, you forgot to fill in one of the sections"}

  after_initialize do |recipe|
    # flash[:message] = "You have initialized a recipe!"
  end
 
  after_find do |recipe|
   # flash[:message] = "You have found a recipe!"
  end

  after_save do |recipe|
    # flash[:message] += "\nYou have saved a recipe!"
  end

  after_destroy do |recipe|
    # flash[:message] = "You have destroyed a recipe!"
  end
 
 
 


end