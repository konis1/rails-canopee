class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :gardens, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tasks
  has_many :notifications, as: :recipient, dependent: :destroy
  has_noticed_notifications
  validates :phone_number, uniqueness: true, format: { with: /\A\+\d+\z/, message: "le format n'est pas valide" }
  validates :email, :code_achat, presence: true
  enum role: [:user, :vip, :admin]
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
