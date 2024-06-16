require_relative 'command'
require 'net/http'
require 'json'

class Pokemon < Command
  BASE_URL = "https://pokeapi.co/api/v2"

  def fetch_pokemon(pokemon_name)
    url = URI("#{BASE_URL}/pokemon/#{pokemon_name}")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  end

  def display_pokemon_info(pokemon)
    info = "Nome: #{pokemon['name']}\n"
    info += "Altura: #{pokemon['height']}\n"
    info += "Largura: #{pokemon['weight']}\n"
    info += "Habilidades:\n"
    pokemon['abilities'].each do |ability|
      info += " - #{ability['ability']['name']}\n"
    end
    info
  end

  def execute(client, message, args)
    pokemon_name = fetch_pokemon(args[0].downcase)
    pokemon_info = display_pokemon_info(pokemon_name)
    client.puts(pokemon_info)
  end
end
