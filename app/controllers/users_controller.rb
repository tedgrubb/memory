class UsersController < ApplicationController
  before_filter :load_user, :only => :show
  before_filter :require_user, :only => [:edit, :update, :destroy]
  
  def show
    @stories = @user.stories.all(:order => "parsed_when DESC")
  end
  
  def search
    query = params[:query].downcase
    if friends = current_user.friends.all
      matches = []
      friends.each do |f| 
        matches << f unless f["name"].downcase.gsub!(query, '').nil?
      end
      matching_names = matches.map {|f| f["name"]}
      matching_ids = matches.map {|f| f["id"]}
    end
    respond_to do |format|
      format.js do
        render :json => {
         :query => params[:query],
         :suggestions => matching_names,
         :data => matching_ids
        }
      end
    end
  end
  
protected

  def load_user
    @user = User.find(params[:id])
  end
  
end