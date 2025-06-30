class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :preparation_time
      t.string :ingredients
      t.string :instructions

      t.timestamps
    end
  end
end
