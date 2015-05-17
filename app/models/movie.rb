class Movie < ActiveRecord::Base
	has_many :movie_locations, :dependent => :destroy
	has_many :locations, :through => :movie_locations
	validates_uniqueness_of :code
	scope :movies_after_one_week_of_release, lambda { where([(" ? - release_date >= ? ")/1.day,Time.now.utc,8]) }
end
