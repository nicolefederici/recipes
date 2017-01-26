class RecipeController < ApplicationController 

  # index route
  get '/projects' do
    @projects = Project.all 
    erb :'projects/index'
  end 

  # show route
  get '/projects/:id' do 
    @project = Project.find_by_id(params[:id])
    if @project 
      erb :'/projects/show'
    else 
      flash[:error] = "Unable to find that project"
      redirect to '/projects'
    end 
  end

  # new route 
  get '/projects/new' do 
    @project = Project.new 
    erb :'/projects/new'
  end

  # create route 
  post '/projects' do 
    @project = Project.new(params)
    if @project.save 
      flash[:notice] = "#{@project.name} was created"
      redirect to "/project/#{@project.id}"
    else 
      flash[:error] = @project.errors.full_messages
      redirect to '/projects/new'
    end 
  end

  # edit route 
  get '/projects/:id/edit' do 
    @project = Project.find_by_id(params[:id])
    if @project 
      erb :'/projects/edit'
    else 
      flash[:error] = "Unable to find that project"
      redirect to '/projects'
    end 
  end

  put '/projects/:id' do 
    @project = Project.find_by_id(params[:id])
    if @project.update(name: params[:name], description: params[:description])
      flash[:notice] = "#{@project.name} was successfully updated!"
      redirect to "/projects/#{@project.id}"
    else 
      flash[:error] = @project.errors.full_messages
      redirect to "/projects/#{@project.id}/edit"
    end
  end

  delete '/projects/:id' do 
    @project = Project.find_by_id(params[:id])
    if @project 
      @project.destroy 
      flash[:notice] = "#{@project.name} was destroyed!"
    else 
      flash[:error] = "Unable to find that project"
    end
    redirect to "/projects"
  end

  get '/projects/:project_id/chunks' do
    @project = Project.find_by_id(params[:project_id])
    @chunks = @project.chunks 
    erb :'chunks/index'
  end 

  get '/projects/:project_id/chunks/:id' do
    @chunk = Chunk.find_by_id(params[:id])
    @chunk.destroy 
    redirect to "/projects/#{params[:project_id]}"
  end

end


#A non logged in user can see all recipes and look at an individual recipe 
#A logged in user can see their recipes in a list that say their recipes 
#and they can create, edit and delete recipes that only the created
