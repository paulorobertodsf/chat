require_relative 'command'

class Help < Command
  def execute(client, message, args)
    client.puts('/poke {nome_do_pokemon} - Retorna detalhes do Pokemon')
  end
end
