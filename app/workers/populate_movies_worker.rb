require 'nokogiri'
require 'open-uri'

class PopulateMoviesWorker
	include Sidekiq::Worker

	def perform(args=nil)

		coming_soon_url = "http://in.bookmyshow.com/movies/comingsoon/"
	  	doc = Nokogiri::HTML(open(coming_soon_url))

		doc.css('.mlist').each do |movie|

			element = movie.at_css('.listhd')
			release_date_text = movie.at_css('.dtblock')

			movie_params =  {
								:code => (find_movie_code element),
								:name => (find_movie_name element),
								:link => (find_movie_link element),
								:release_date => (find_release_date release_date_text)
					 	    }

			movie = Movie.find_by_code(movie_params[:code])

			update_or_create_movie(movie,movie_params)

		end

	PopulateMoviesWorker.perform_in(1.day,nil)
	end

private
		  	
	def find_movie_code selector
		selector.css('a').attribute('href').to_s.split('/')[3].strip
	end

	def find_movie_link selector
		selector.css('a').attribute('href').to_s.split('/')[2].strip
	end

	def find_movie_name selector
		selector.css('a').text.strip
	end

	def find_release_date selector
		Time.parse(selector).utc rescue nil
	end

	def update_or_create_movie movie,movie_params	
		unless movie 
			Movie.create(movie_params)
		else
			movie.update_attribute(:release_date,movie_params[:release_date]) if movie.release_date != movie_params[:release_date]
		end 
	end


end
