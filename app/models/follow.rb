class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :line
  
  validates :user_id, presence: true
  validates :line_id, presence: true
end
