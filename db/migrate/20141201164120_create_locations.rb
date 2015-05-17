class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :code
      t.timestamps
    end
    add_index :locations, [:name], :name => "index_on_name"
  end
end
