class Comment < ApplicationRecord
  belongs_to :fish
  belongs_to :user
  validates :body, presence: true, length: { minimum: 15 }

  def category_slug
    self.fish.category.slug
  end
  
  def fish_title
    Fish.deslugify(self.fish.title)
  end

  def fish_slug
    self.fish.slug
  end
end
