class Comment < ApplicationRecord
  belongs_to :fish
  belongs_to :user
  
end