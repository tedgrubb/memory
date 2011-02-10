class StoriesController < ApplicationController
  
  before_filter :require_owner
  before_filter :load_story, :except => [:index, :create, :new]
  
  def index
    @stories = Story.all
  end
  
  def show
    
  end
  
  def create
    if @story = Story.create_with_user_stories(params, current_user)
      redirect_to @story
    else
      flash[:notice] = "Fail!"
    end
  end
  
  def new
    
  end
  
  def edit
    
  end
  
protected
  
  def require_owner
    # Stub
    return true
  end
  
  def load_story
    @story = Story.find(params[:id])
  end
  
end