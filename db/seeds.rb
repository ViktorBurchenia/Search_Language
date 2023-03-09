# frozen_string_literal: true

require 'json'

data = JSON.parse(File.read('./db/data.json'))

data.each do |language_data|
  Language.create(name: language_data['name'], language_type: language_data['type'].gsub(/, /, ','),
                  designed_by: language_data['designed by'].gsub(/, /, ','))
end
