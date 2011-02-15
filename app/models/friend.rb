class Friend
  def initialize(user)
    @fb = Facebook.new(user.token)
  end

  # options: limit, offset
  def all(query={})
    @fb.get('/me/friends', query)
  end
end
