class Story < ActiveRecord::Base
  has_many :user_stories
  has_many :users, :through => :user_stories
  has_many :comments
  
  validates_presence_of :location, :when, :what
  
  attr_accessor :who
  
  def self.create_with_user_stories(params, user, friends = [])
    
    transaction do
      params[:story].delete(:who)
      params[:story][:parsed_when] = Story.parse_date(params[:story][:when])
      story = create(params[:story])
      user_story = UserStory.new
      user_story.story = story
      user_story.user = user
      user_story.owner = true
      user_story.save
      return story
    end
  
  end
  
  
private
  def self.parse_date(raw_date)
    parsed_date = Chronic.parse(raw_date)
    result = parsed_date ? parsed_date.to_date : nil
  end
end
