class Category < ApplicationRecord
  has_many :topic_categoryships
  has_many :topics, :through => :topic_categoryships
end
