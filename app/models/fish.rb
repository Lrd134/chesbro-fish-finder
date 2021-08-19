class Fish < ApplicationRecord
  has_many :comments
  belongs_to :category
  belongs_to :user
  validates :title, presence: true, exclusion: { in: %w( - ? _ + - . , ; : ' " [ ] { } \ | = ! @ # $ % ^ & * ),
    message: "%{value} is reserved." }, length: { minimum: 3}
  after_validation :capitalize_title
  has_one_attached :fish_image

  def slug
    self.title = self.title.split(" ").map { | word | word.downcase }.join("-")
  end

  def capitalize_title
    self.title = self.title.split(" ").map { | word | word.capitalize }.join(" ")
  end
  
  def self.deslugify(slug)
    slug.split("-").map { | word | word.capitalize }.join(" ")
  end
  def self.find_by_slug(slug)
    find_by(title: deslugify(slug))
  end
end
