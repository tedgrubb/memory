class User < ActiveRecord::Base
  has_many :user_stories
  has_many :stories, :through => :user_stories
  has_many :comments

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end  
  end
end
