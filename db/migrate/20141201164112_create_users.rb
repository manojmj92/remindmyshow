class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.timestamps
    end
    add_index :users, [:email], :name => "index_on_email"
  end
end