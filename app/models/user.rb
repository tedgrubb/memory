class User < ActiveRecord::Base
  has_many :user_stories
  has_many :stories, :through => :user_stories
  has_many :comments

  def self.authenticate_with_omniauth(auth)
    user = find_by_provider_and_uid(auth["provider"], auth["uid"]) 
    if user
      # Updating existing info in case it's changed
      user.update_attributes(:raw_auth => auth, :token => auth["credentials"]["token"], :name => auth["user_info"]["name"])
      user
    else
      create_with_omniauth(auth)  
    end
  end

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.raw_auth = auth
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.token = auth["credentials"]["token"]  
      user.name = auth["user_info"]["name"]  
    end  
  end

  def friends
    Friend.new(self)
  end
end
