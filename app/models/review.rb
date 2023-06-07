class Review < ApplicationRecord
  belongs_to :user
  belongs_to :plant
  validates :note, presence: true
end
