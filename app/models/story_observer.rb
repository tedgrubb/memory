class StoryObserver < ActiveRecord::Observer

  # Had to move this into story.rb since it was posting before the other UserStories were created 

  # include Rails.application.routes.url_helpers
  # 
  # default_url_options[:host] = URL_HOST
  # 
  # def after_create(story)
  #   fb = Facebook.new(story.owner.token)
  #   fb.post('/me/feed', {
  #     :link => story_url(story),
  #     :name => "#{story.when} @ #{story.location}",
  #     :message => description(story)
  #   })
  # end
  # 
  # def description(story)
  #   result = "#{story.what} "
  #   tags = []
  #   story.users.each do |u|
  #     tags << "@[{#{u.uid}}:1:{#{u.name}}]"
  #   end
  #   result += tags.join(", ")
  #   result
  # end
  
end
