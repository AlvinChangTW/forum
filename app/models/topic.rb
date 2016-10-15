class Topic < ApplicationRecord
  validates_presence_of :name
  has_many :comments, :dependent => :destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships
  belongs_to :user
  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user
end
