# require 'digest/sha1'

class User < ApplicationRecord

  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :confirmable

  has_many :test_passages
  has_many :tests, through: :test_passages

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id' #:user_id
  has_many :gists
  has_many :feedbacks, dependent: :destroy

  has_many :badges_users, dependent: :destroy
  has_many :badges, through: :badges_users

  validates :email, presence: true, uniqueness: true

  # has_secure_password

  def get_level_tests(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
