class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :user_id
      t.string :ingredients
      t.string :directions
      t.integer :servings
      t.string :nutrition
      t.string :story
    end
  end
end