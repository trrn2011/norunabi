class Post < ApplicationRecord
  belongs_to :user
  belongs_to :line
  validates :content,  length: { maximum: 100 }
  validates :user_id, presence: true
  validates :cloud_level, presence: true
  validates :line_id, presence: true
  
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  
end
