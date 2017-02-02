class AddVideoLinkToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes,:video_link,:string
  end
end
