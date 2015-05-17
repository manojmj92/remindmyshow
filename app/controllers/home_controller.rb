class HomeController < ApplicationController


	def index

	end

	def create
		user_movie_location_params = {
					:user_id => (User.find_or_create_by(:email => params.delete(:email))).id,
					:movie_location_id => (MovieLocation.find_or_create_by(create_associations(params))).id
				 }

		UserMovieLocation.find_or_create_by(user_movie_location_params)

		render :json => {:status => true}
	end

	def check_booking_started

		movie_id = params[:movie_id]
		location_id = params[:location_id]

		movie_location = MovieLocation.where(:movie_id => movie_id,:location_id => location_id)

		@status = true if movie_location and movie_location.started

		@status = booking_started?(movie_code,movie_location) unless @status

		render :json => {:status => @status}

	end

	def autosuggest_movie
		@results = Movie.where(['name LIKE ?',"%#{params[:query]}%"]) 
		render_json
	end

	def autosuggest_location
		@results = Location.where((['name LIKE ?',"%#{params[:query]}%"]))
		render_json
	end

	private

	def render_json 
		render :json => {"suggestions" => @results.as_json(:only => [:name,:id])}
	end


	def create_associations(params)
		{
			:movie_id => (Movie.find_by :name => params[:movie_name]).id,
			:location_id => (Location.find_by :name => params[:location]).id
		}

	end


	 def booking_started?(movie_code,location_code)

	  	response = Nokogiri::HTML(open(url_builder(location_code)))

		  match = (response.to_s.match /.*aiEV=(.*);aiSRE=.*/).captures[0]

		  match.include? movie_code
	end




end
