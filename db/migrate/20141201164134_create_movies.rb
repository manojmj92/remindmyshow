class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :code
      t.string :link
      t.datetime :release_date
      t.timestamps
    end
    add_index :movies, [:name], :name => "index_on_name"
    add_index :movies, [:release_date], :name => "index_on_release_date"
  end
end
