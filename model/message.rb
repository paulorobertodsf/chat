class Message
  attr_reader :message, :author

  def initialize(text, user, receiver)
    @text ||= text
    @author ||= user
    @receiver ||= receiver
    @time_create ||= Time.new
  end

  def getmessage
    message = {
      "text" => @text,
      "author" => @author,
      "time_create" => @time_create
    }
    return message
  end
end
