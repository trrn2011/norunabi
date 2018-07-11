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
  
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post
  
  def fav(post)
    unless post.user == self
      self.favorites.find_or_create_by(post_id: post.id)
    end
  
  end
  
  def fav?(post)
    self.favorite_posts.include?(post)
  end
  
  def count_fav
    posts = self.posts.all
    @count_fav = 0
    posts.each do |post|
      @count_fav += post.favorited_users.count
    end
    
    return @count_fav
    
  end
  
   
end
