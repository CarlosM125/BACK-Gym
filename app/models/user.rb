class User < ApplicationRecord
  has_secure_password
  belongs_to :gimnasio
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
