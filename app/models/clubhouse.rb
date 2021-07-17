class Clubhouse < ApplicationRecord
  has_many :member_applications

  validates :name, :email_address, presence: true
end
