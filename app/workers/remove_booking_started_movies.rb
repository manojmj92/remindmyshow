class RemoveBookingStartedMovies
  include Sidekiq::Worker

def perform(args=nil)
	Movie.find_in_batches(:batch_size => 10) do |batch|
		batch.each do|movie|
			if (old_movie?(movie) and movie_not_requested?(movie))
				movie.destroy
			end
		end
	end
	RemoveBookingStartedMovies.perform_in(7.days,nil)
end

private

	def old_movie?(movie)
		((Time.now.utc > movie.release_date) and (TimeDifference.between(t, r).in_days >= 8)) ? (return true) : (return false) 
	end

	def movie_note_requested?(movie)
		movie.movie_locations.blank?
	end


end