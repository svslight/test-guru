class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests
  
  validates :email, presence: true

  def get_level_tests(level)
    tests.where(level: level)
  end
end
