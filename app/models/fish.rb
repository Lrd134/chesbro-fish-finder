class Fish < ApplicationRecord
  has_many :comments
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, exclusion: { in: %w( - ? _ + - . , ; : ' " [ ] { } \ | = ! @ # $ % ^ & * ),
    message: "%{value} is reserved." }, length: { minimum: 3}

  after_validation :capitalize_title
  before_save :update_category
  before_create :force_unsolved

  has_one_attached :fish_image

  def slug
    self.title = self.title.split(" ").map { | word | word.downcase }.join("-")
  end

  def category_slug
    self.category.slug
  end

  def capitalize_title
    self.title = self.title.split(" ").map { | word | word.capitalize }.join(" ")
  end

  def update_category
    self.solved == true ? self.category=(Category.find_by_slug('identified')) : self.category=(Category.find_by_slug('unidentified'))
  end

  def force_unsolved
    self.solved = 0
    self.category = Category.find_by_slug('unidentified')
  end
  
  def self.newest
    self.order(created_at: :desc).limit(1)
  end

  def self.last_solved
    self.where('category_id == 1').order(updated_at: :desc).limit(1)
  end

  def self.slugs_match?(params, model)
    find_by_slug(params['fish_slug']).id == params[model]['fish_id'].to_i
  end
  
  def self.deslugify(slug)
    slug.split("-").map { | word | word.capitalize }.join(" ")
  end

  def self.find_by_slug(slug)
    find_by(title: deslugify(slug))
  end
end
