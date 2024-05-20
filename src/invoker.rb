class Invoker
  attr_reader :commands

  def initialize
    import_commands
    @commands = {
      'connect' => Connect.new
    }
  end

  private
  def import_commands
    Dir.glob('./command/*.rb').each do |file|
      if !file.include? 'command.rb'
        require file
      end
    end
  end
end
