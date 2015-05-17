class CreateUserMovieLocations < ActiveRecord::Migration
  def change
    create_table :user_movie_locations do |t|
      t.integer :user_id
      t.integer :movie_location_id
      t.boolean :email_sent, :default => false
      t.timestamps
    end
    add_index :user_movie_locations, [:movie_location_id], :name => "index_on_movie_location_id"
  end
end
