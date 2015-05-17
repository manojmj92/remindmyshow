class CreateMovieLocations < ActiveRecord::Migration
  def change
    create_table :movie_locations do |t|
      t.integer :movie_id
      t.integer :location_id
      t.boolean :started, :default => false
      t.timestamps
    end
    add_index :movie_locations, [:started], :name => "index_on_started"
  end
end
