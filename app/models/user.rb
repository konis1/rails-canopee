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
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+\d+\z/, message: "le format n'est pas valide" }
end
