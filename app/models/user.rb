class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :gardens, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_noticed_notifications

  validates :email, presence: true, format: { with: /\A[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}/, message: "Format email incorrect !" }
  validates :nom, presence: true, if: :placed_order
  validates :prenom, presence: true, if: :placed_order
  validates :phone_number, presence: true, if: :placed_order
  validates :adresse_numero, presence: true, if: :placed_order
  validates :adresse_type_voie, presence: true, if: :placed_order
  validates :adresse_nom_voie, presence: true, if: :placed_order
  validates :adresse_ville, presence: true, if: :placed_order
  validates :adresse_code_postal, presence: true, if: :placed_order

  enum role: %i[user vip admin]
  after_initialize :set_default_role, if: :new_record?

  def vip?
    role == "vip"
  end

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
