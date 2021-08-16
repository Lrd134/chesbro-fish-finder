class Comment < ApplicationRecord
  belongs_to :fish
  belongs_to :user
  validates :body, presence: true, length: { minimum: 15 }
end
