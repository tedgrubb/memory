class UsersController < ApplicationController
  before_filter :load_user
  before_filter :require_user, :only => [:edit, :update, :destroy]
  
  def show
    @stories = @user.stories.all(:order => "parsed_when DESC")
  end
  
protected

  def load_user
    @user = User.find(params[:id])
  end
  
end