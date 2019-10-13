require 'city_details_html_parser'
class AddLatLongAndUpdateTheCities < ActiveRecord::Migration[5.2]
 
 def up
  add_column :cities, :latitude, :float
  add_column :cities, :longitude, :float

  city_details_parser = CityDetailsHtmlParser.new()
  parsed_cities = city_details_parser.parsed_cities
  parsed_cities.each do |i_data|
   current_city = City.find_by_name(i_data["name"])
   if current_city.blank?
    current_city = City.new(i_data)
   else
    current_city.latitude = i_data["latitude"]
    current_city.longitude = i_data["longitude"]
   end
   current_city.save if current_city.changed?
  end
 end

 def down
  remove_column :cities, :latitude, :float
  remove_column :cities, :longitude, :float
 end
end
