class Story < ActiveRecord::Base
  has_many :user_stories
  has_many :users, :through => :user_stories
  has_many :comments
  
  def self.create_with_user_stories(params, user, friends = [])
    
    transaction do
      story = create(params[:story])
      user_story = UserStory.new
      user_story.story = story
      user_story.user = user
      user_story.owner = true
      user_story.save
      return story
    end
  
  end
  
end
