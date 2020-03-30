class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  attachment :profile_image

  validates :introduction, length: { maximum: 50 }

  validates :name, length: { minimum: 2, maximum: 20 },
  			presence: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy


end
