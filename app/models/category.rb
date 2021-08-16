class Category < ApplicationRecord
  #NEED TO LET USERS CREATE CATEGORIES
  has_many :fish
  has_many :users, through: :fish
  def self.find_by_slug(slug)
    Category.find_by(name: slug)
  end
  def slug
    self.name
  end
end
