class Line < ApplicationRecord
  has_many :posts
  validates :name, presence: true
  validates :line_cd, presence: true
  validates :side, presence: true
  
  has_many :user
end
