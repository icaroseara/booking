class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :reservations
  
  validates :name, presence: true
  validates :email, presence: true, email: true, uniqueness: true
end
