p "========================================"
p "    Will you need an umbrella today?    "
p "========================================"

p "Where are you located?"

# user_location = gets.chomp
user_location = "Memphis"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

p "Checking the weather at " + user_location + "...."

require "open-uri"
raw_response = URI.open(gmaps_url).read

require "json"
parsed_response = JSON.parse(raw_response)

results_array = parsed_response.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

p "Your coordinates are " + latitude.to_s + ", " + longitude.to_s + "."

# pirate API

pirate_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"

raw_pirate = URI.open(pirate_url).read

parsed_pirate = JSON.parse(raw_pirate)

weather = parsed_pirate.fetch("currently")

temp = weather.fetch("temperature")

p "It is currently " + temp.to_s + "°F."

hourly = parsed_pirate.fetch("hourly")

hourly_data = hourly.fetch("data")

x = hourly_data.at(0)

next_hour = x.fetch("summary")

p "Next hour: " + next_hour

precip = x.fetch("precipProbability")

11.times do |index|
  x = hourly_data.at(index)
  precip = x.fetch("precipProbability")
  precip_round = precip.round
  p "In " + index.to_s + " hours, there is a " + precip_round.to_s + "% chance of precipitation."
end

