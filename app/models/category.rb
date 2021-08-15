class Category < ApplicationRecord
  def self.find_by_slug(slug)
    Category.find_by(name: slug)
  end
  def slug
    self.name
  end
end
