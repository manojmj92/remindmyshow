require 'nokogiri'
require 'open-uri'
require 'json'

class PopulateLocationsWorker
	include Sidekiq::Worker

	def perform(args=nil)

		locations_url = 'http://in.bookmyshow.com/getJSData/?cmd=GETREGIONS'

		response = Nokogiri::HTML(open(locations_url))

		region_list = (response.to_s.match /.*regionlst=(.*);var regionalias=.*/).captures[0]

		list_json =  JSON.parse(region_list)

		list_json.keys.each do |key|
			list_json[key].each do |value|
				location_params = {
									:name => (value["name"]),
									:code => (value["code"])
								  }
				Location.create(location_params)
			end
		end

	PopulateLocationsWorker.perform_in(7.days,nil)
	end
end