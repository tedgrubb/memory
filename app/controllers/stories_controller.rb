class StoriesController < ApplicationController
  
  before_filter :require_owner
  
  def index
    
  end
  
  def show
    
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
  
end