class Topic < ApplicationRecord
  validates_presence_of :name
  has_many :comments
end
