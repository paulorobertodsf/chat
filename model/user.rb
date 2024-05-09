class User
  attr_accessor :username

  def initialize(ip_address, username)
    @ip_address = ip_address
    @username = username
  end
end
