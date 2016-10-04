class Comment < ApplicationRecord
  belongs_to :topic
  validates_presence_of :content
end
