class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :engineers, dependent: :destroy
end
