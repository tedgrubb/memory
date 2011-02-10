class User < ActiveRecord::Base
  has_many :user_stories
  has_many :stories, :through => :user_stories
  has_many :comments

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.raw_auth = auth
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.token = auth["credentials"]["token"]  
      user.name = auth["user_info"]["name"]  
    end  
  end
end
