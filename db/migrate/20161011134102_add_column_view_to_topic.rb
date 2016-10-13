class AddColumnViewToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :view, :integer ,:default =>0
    add_index :topics, :view
  end
end
