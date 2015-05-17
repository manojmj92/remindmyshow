class Location < ActiveRecord::Base
	has_many :movie_locations
	has_many :movies, :through => :movie_locations
	validates_uniqueness_of :name
end
