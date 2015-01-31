class CreateExoplanets < ActiveRecord::Migration
  def change
    create_table :exoplanets do |t|
      t.string :name
      t.string :letter
      t.string :discovery_method

      t.timestamps null: false
    end
  end
end
