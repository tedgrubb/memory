class User < ActiveRecord::Base
  has_many :stories, :through => :user_story
  has_many :comments
end
