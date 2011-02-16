class Story < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  default_url_options[:host] = URL_HOST

  has_many :user_stories
  has_many :users, :through => :user_stories
  has_many :comments
  has_one :owner,  :through => :user_stories, :source => :user, :conditions => { 'user_stories.owner' => true }

  # has_attached_file :photo,
  #                   :storage        => :s3,
  #                   :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  #                   :bucket         => "memoirie_#{Rails.env}",
  #                   :path           => ":class/:id/:basename_:style.:extension",
  #                   :styles         => { :thumb => "100x100>" }
  
  validates_presence_of :location, :when, :what
  
  attr_accessor :who
  
  def self.create_with_user_stories(params, user)
    
    transaction do
      friends = params[:story].delete(:who)
      params[:story][:parsed_when] = Story.parse_date(params[:story][:when])

      story = new(params[:story])
      story.user_stories.build(:user => user, :story => story, :owner => true)
      story.save
      #Story.create_user_story(user, story, true)

      friends.split(",")[0].each do |friend|
        if f = friend.split("|")
          u = User.find_or_create_by_uid(f.first.to_s, f.last.to_s)
          Story.create_user_story(u, story, false)
        end
      end
      story.facebook_post
      return story
    end
  
  end
  
  def facebook_post
    fb = Facebook.new(self.owner.token)
    fb.post('/me/feed', {
      :link => story_url(self),
      :name => "#{self.when} @ #{self.location}",
      :message => self.message,
      :description => "Start sharing memories with friends and family on facebook. #{root_url}"
    })
  end
  
  
  def message
    result = "#{self.what}"
    tags = []
    self.users.each do |u|
      tags << "@[#{u.uid}:1:#{u.name}]"
    end
    result += " (cc: #{tags.join(", ")})"
    result
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
