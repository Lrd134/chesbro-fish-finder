class Fish < ApplicationRecord

  after_validation :capitalize_title, :update_category
  before_create :force_unsolved
  validates :title, presence: true
  has_one_attached :fish_image

  def slug
    self.title = self.title.split(" ").map { | word | word.downcase }.join("-")
  end

  def capitalize_title
    self.title = self.title.split(" ").map { | word | word.capitalize }.join(" ")
  end

  def update_category
    self.solved == 1 ? self.category_id=(Category.find_by_slug('identified').id) : self.category_id=(Category.find_by_slug('unidentified').id)
  end
  def force_unsolved
    self.solved = 0
    self.category_id = Category.find_by_slug('unidentified').id
  end
  def category_slug
    Category.find(self.category_id).slug
  end
  def self.deslugify(slug)
    slug.split("-").map { | word | word.capitalize }.join(" ")
  end
  def self.find_by_slug(slug)
    find_by(title: deslugify(slug))
  end
end
