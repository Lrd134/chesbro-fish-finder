class Category < ApplicationRecord
  has_many :fish
  def self.find_by_slug(slug)
    Category.find_by(name: slug)
  end
  def slug
    self.name
  end
end
