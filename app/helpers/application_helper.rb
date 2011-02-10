module ApplicationHelper
  
  def story_title(story)
    "#{story.when} @ #{story.location}"
  end
  
end
