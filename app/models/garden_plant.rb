class GardenPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  has_many :tasks, dependent: :destroy
  validates :nickname, :pot_color, :status, presence: true
  validates :nickname, uniqueness: true
  enum :status, {
    pre_selected: 0,
    selected: 10,
    validated: 20
  }
  # validates :pot_color, inclusion: {in: %w()}
  has_one_attached :photo

  def score
    return 25
  end

end
