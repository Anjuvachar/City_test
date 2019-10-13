require 'open-uri'

class CityDetailsHtmlParser

 def parsed_cities
   html_page = read_city_details
   parsed_cities = parse_city_details(html_page)
   parsed_cities
 end 

  private
  def read_city_details
    Nokogiri::HTML(open(CITY_DETAILS_HTML_URL))
  end

  def parse_city_details(html_page)
   column_names = html_page.css("table tr th").map(&:text) 
   rows = html_page.css("table tr")
   rows.shift
   all_rows = rows.map do |row|
    row_values = row.css('td').map(&:text)
    row_values
   end
   parsed_cities = []
   all_rows.each do |i_row|
    current_row = {}
    current_row["name"] = i_row[0].split(", ")[0]
    current_row["state"] = i_row[0].split(", ")[1]
    current_row["country"] = i_row[0].split(", ")[2]
    current_row[column_names[1].downcase] = i_row[1]
    current_row[column_names[2].downcase] = i_row[2]
    parsed_cities << current_row
   end
   parsed_cities
  end

end