class UserMovieLocation < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie_location
end
