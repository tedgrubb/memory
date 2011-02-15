class StoryObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers
  
  default_url_options[:host] = URL_HOST

  def after_create(story)
    fb = Facebook.new(story.owner.token)
    fb.post('/me/feed', {
      :link => story_url(story),
      :name => "#{story.when} @ #{story.location}",
      :description => story.what
    })
  end
end
