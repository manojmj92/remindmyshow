namespace :populate_data do
  desc "TODO"

  task run_sidekiq: :environment do
  	EmailNotifierWorker.perform_async(nil)
  	PopulateMoviesWorker.perform_async(nil)
  	PopulateLocationsWorker.perform_async(nil)
  	RemoveBookingStartedMovies.perform_async(nil)
  end
end
