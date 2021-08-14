class Fish < ApplicationRecord

  after_validation :capitalize_title, :update_category
  before_create :force_unsolved
  validates :title, presence: true

  def slug
    self.title = self.title.split(" ").map { | word | word.downcase }.join("-")
  end

  def capitalize_title
    self.title = self.title.split(" ").map { | word | word.capitalize }.join(" ")
  end

  def update_category
    self.solved == 1 ? self.category_id = 1 : self.category_id = 2
  end
  def force_unsolved
    self.solved = 0
    self.category_id = 2
  end

  def self.deslugify(slug)
    slug.split("-").map { | word | word.capitalize }.join(" ")
  end
  def self.find_by_slug(slug)
    find_by(title: deslugify(slug))
  end
end