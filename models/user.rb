class User < ApplicationRecord
  belongs_to :company
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { member: 0, manager: 1, admin: 2 }, _prefix: true
  enum root_role: { none: 0, manager: 1, admin: 2 }, _prefix: true

  before_validation :set_default_password

  def set_default_password
    self.password = self.password_confirmation = email if encrypted_password.blank?
  end
end
