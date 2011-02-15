class Friend
  def initialize(user)
    @fb = Facebook.new(user.token)
  end

  # options: limit, offset
  def all(options={})
    @fb.get('/me/friends', :query => options)
  end
end
