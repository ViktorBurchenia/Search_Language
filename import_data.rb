require 'json'

data = JSON.parse(File.read('data.json'))

data.each do |language_data|
  language = Language.create(name:  language_data['name'], language_type: language_data['type'], designed_by: language_data['designed by'])
end
