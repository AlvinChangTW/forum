class Topic < ApplicationRecord
  validates_presence_of :name
  has_many :comments, :dependent => :destroy
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships
  belongs_to :user
  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user
  has_many :subscribes, :dependent => :destroy
  has_many :subscribed_users, :through => :subscribes , :source => :user
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png", default_style:"100x100"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
