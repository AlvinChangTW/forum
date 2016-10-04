class AddCategoriesNameIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :name
  end
end
