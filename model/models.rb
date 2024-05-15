Dir.glob('./model/*.rb').each do |file|
  if !file.include? 'models.rb'
    require file
  end
end
