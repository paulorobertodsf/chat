class Invoker
  attr_reader :commands

  def initialize
    import_commands
    @commands = {
      'help' => Help.new,
      'poke' => Pokemon.new,
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
