class Link
  attr_reader :users

  def initialize(user)
    @users = []

    if @users.length < 2
      @users.append(user)
    end
  end
end
