require 'nokogiri'
require 'open-uri'

class EmailNotifierWorker
  include Sidekiq::Worker

  def perform(args=nil)
  	#iterate movie_locations. each one will be unique. so duplicates are avoided
  		#find movie_code and location_code
  		 #if movie has begun
  		 	#find all users with movie_location_code and send mail
  		 	#destroy movie location and user movie location
  		 #else repeat

  	MovieLocation.booking_not_started.find_in_batches(:batch_size => 10) do |batch|

  		batch.each do |movie_location|

  			params = find_movie_and_location_params movie_location

  			if booking_started?(params[:movie_code],params[:location_code])

  				movie_location.user_movie_locations.each do |user_movie_location|
  					send_email({:email => user_movie_location.user.email}.merge!(params))
  					user_movie_location.update_attribute(:email_sent,true)
  				end

  				movie_location.update_attribute(:started,true)

  			end
  		end

  	end

  	EmailNotifierWorker.perform_in(2.minutes, nil)

  end

  private 
  
  def send_email(params)
  	BookingStartedMailer.booking_started_notification(params).deliver
  end

  def find_movie_and_location_params movie_location

  	movie = movie_location.movie
  	location = movie_location.location


  	{ 	:movie_code => movie.code,
  		:movie_link => movie.link,
  		:movie_name => movie.name,
  		:location_code => location.code,
  		:location_name => location.name
  	}

  end

  def url_builder(location_code)
	"http://in.bookmyshow.com/getJSData/?file=/data/js/GetEvents_MT.js&cmd=GETEVENTSWEB&et=MT&rc=" + location_code
  end

   def booking_started?(movie_code,location_code)

      response = Nokogiri::HTML(open(url_builder(location_code)))

      match = (response.to_s.match /.*aiEV=(.*);aiSRE=.*/).captures[0]

      match.include? movie_code
  end





end
