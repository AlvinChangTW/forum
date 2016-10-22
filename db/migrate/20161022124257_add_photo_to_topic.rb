class AddPhotoToTopic < ActiveRecord::Migration[5.0]
  def change
    add_attachment :topics, :picture
  end
end
