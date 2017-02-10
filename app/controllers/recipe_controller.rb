class RecipeController < ApplicationController 

 # index route

  get '/recipes' do
    @recipes = Recipe.all 
    erb :'recipes/index'
  end 

# new route 
  get '/recipes/new' do
    authenticate_user 
    @recipe = Recipe.new 
    erb :'/recipes/new'
  end


  # show route
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :'/recipes/show'
    else 
      flash[:message] = "Unable to find that recipe"
      redirect to '/recipes'
    end
  end

  
  # create route 
  post '/recipes' do
    authenticate_user
    @recipe = current_user.recipes.build(params)
    #this build method (adds another one onto the collection proxy that is whomever's recipes), AKA: it takes the place of these next two lines by doing them together in one action.
    # @recipe = Recipe.new(params)
    # @recipe.user_id = current_user.id
    if @recipe.save 
     flash[:message] = "#{@recipe.title} was created"
      redirect to "/recipes/#{@recipe.id}"
    else 
      flash[:message] = @recipe.errors.full_messages
      redirect to '/recipes/new'
    end 
  end

  # edit route 
  get '/recipes/:id/edit' do 
    authenticate_user
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :'/recipes/edit'
    else 
      flash[:message] = "Unable to find that recipe"
      redirect to '/recipes'
    end 
   
  end

  put '/recipes/:id' do
    authenticate_user
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user_id == current_user.id
      if @recipe.update(title: params[:title], ingredients: params[:ingredients], directions: params[:directions], nutrition: params[:nutrition], servings: params[:servings], story: params[:story], video_link:params[:video_link])
         flash[:message] = "#{@recipe.title} was successfully updated!"
         redirect to "/recipes/#{@recipe.id}"
      else 
        flash[:message] = @recipe.errors.full_messages.join("|")
        redirect to "/recipes/#{@recipe.id}/edit"
      end
    else 
      flash[:message] = "you can't edit recipes you don't own"
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  delete '/recipes/:id' do
    authenticate_user 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.user == current_user 
      if @recipe 
        @recipe.destroy 
        flash[:message] = "#{@recipe.title} was destroyed!"
      else 
        flash[:message] = "Unable to find that recipe"
      end
      redirect to "/recipes"
    else
      flash[:message] = "you can delete only the recipes you have created!"
      redirect to "recipes/#{@recipe.id}"
    end  
  end

end




