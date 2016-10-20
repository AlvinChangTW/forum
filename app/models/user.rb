class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics
  has_many :comments
  has_many :likes
  has_many :liked_topics, :through => :likes, :source => :topic

  def admin?
    self.role=="admin"
  end
end

