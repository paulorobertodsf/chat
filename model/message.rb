class Message
  attr_reader :message, :author

  def initialize(text, user, receiver)
    @text ||= text
    @author ||= user
    @receiver ||= receiver
    @time_create ||= Time.new
  end

  def get_message
    message = {
      "text" => @text,
      "author" => @author,
      "time_create" => @time_create,
      "is_command" => @text[0] == '/'
    }
    return message
  end
end
