class Story < ActiveRecord::Base
  has_many :user_stories
  has_many :users, :through => :user_stories
  has_many :comments

  has_attached_file :photo,
                    :storage        => :s3,
                    :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
                    :bucket         => "memoirie_#{Rails.env}",
                    :path           => ":class/:id/:basename_:style.:extension",
                    :styles         => { :thumb => "100x100>" }
  
  validates_presence_of :location, :when, :what
  
  attr_accessor :who
  
  def self.create_with_user_stories(params, user)
    
    transaction do
      friends = params[:story].delete(:who)
      params[:story][:parsed_when] = Story.parse_date(params[:story][:when])

      story = create(params[:story])

      Story.create_user_story(user, story, true)

      friends.split(",").each do |f|
        u = User.find_or_create_by_uid(f.to_s)
        Story.create_user_story(u, story, false)
      end
      
      return story
    end
  
  end
  
  
private

  def self.create_user_story(user, story, owner = false)
    user_story = UserStory.new
    user_story.story = story
    user_story.user = user
    user_story.owner = owner 
    user_story.save
  end

  def self.parse_date(raw_date)
    parsed_date = Chronic.parse(raw_date)
    result = parsed_date ? parsed_date.to_date : nil
  end
end
