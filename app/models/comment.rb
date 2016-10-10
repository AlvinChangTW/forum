class Comment < ApplicationRecord
  belongs_to :topic, :counter_cache => true
  validates_presence_of :content
  belongs_to :user
end
