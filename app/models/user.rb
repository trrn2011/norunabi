class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  
  mount_uploader :image, ImageUploader 
  has_many :posts
  
  has_many :follows
  has_many :follow_lines, through: :follows, source: :line
  
  def follow(line)
     self.follows.find_or_create_by(line_id: line.id)
  end
  
  def unfollow(line)
    follow_line = self.follows.find_by(line_id: line.id)
    if follow_line
      follow_line.destroy
    end
  end
  
  def follow?(line)
    self.follow_lines.include?(line)
  end
  
   
end
