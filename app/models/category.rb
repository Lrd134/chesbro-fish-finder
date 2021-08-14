class Category < ApplicationRecord
  def self.find_by_slug(slug)
    Category.find_by(title: slug)
  end
end
