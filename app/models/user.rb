class User < ApplicationRecord
  # before_create :set_default_avatar
  # def set_default_avatar
  #   self.avatar.attach("/assets/images/default_avatar.jpg")
  # end

  has_one_attached :avatar
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
