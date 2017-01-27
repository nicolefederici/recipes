class RecipeController < ApplicationController 

  # index route
  get '/recipes' do
    @recipes = Recipe.all 
    erb :'recipes/index'
  end 

  # show route
  get '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :'/recipes/show'
    else 
      flash[:error] = "Unable to find that recipe"
      redirect to '/recipes'
    end 
  end

  # new route 
  get '/recipes/new' do 
    @recipe = Recipe.new 
    erb :'/recipes/new'
  end

  # create route 
  post '/recipes' do 
    @recipe = Recipe.new(params)
    if @recipe.save 
      flash[:notice] = "#{@recipe.name} was created"
      redirect to "/recipes/#{@recipe.id}"
    else 
      flash[:error] = @recipe.errors.full_messages
      redirect to '/recipes/new'
    end 
  end

  # edit route 
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :'/recipes/edit'
    else 
      flash[:error] = "Unable to find that recipe"
      redirect to '/recipes'
    end 
  end

  put '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.update(name: params[:name], description: params[:description])
      flash[:notice] = "#{@recipe.name} was successfully updated!"
      redirect to "/recipes/#{@recipe.id}"
    else 
      flash[:error] = @recipe.errors.full_messages
      redirect to "/recipes/#{@recipe.id}/edit"
    end
  end

  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      @recipe.destroy 
      flash[:notice] = "#{@recipe.name} was destroyed!"
    else 
      flash[:error] = "Unable to find that recipe"
    end
    redirect to "/recipes"
  end

  get '/recipes/:recipe_id/chunks' do
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @chunks = @recipe.chunks 
    erb :'chunks/index'
  end 

  get '/recipes/:recipe_id/chunks/:id' do
    @chunk = Chunk.find_by_id(params[:id])
    @chunk.destroy 
    redirect to "/recipes/#{params[:recipe_id]}"
  end

end


#A non logged in user can see all recipes and look at an individual recipe 
#A logged in user can see their recipes in a list that say their recipes 
#and they can create, edit and delete recipes that only the created
