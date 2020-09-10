class Badge < ApplicationRecord
  RULE_TYPES = %w[
    attempt
    category
    level].freeze

  RULE_VALUES = [
    '0-easy',
    '1-elementary',
    '2-advanced',
    '3-hard',
    '1',
    'Backend',
    'Frontend'].freeze
  
  IMAGES = [
    ['Leader attempt', 'winner_attempt.png'],
    ['Leader category', 'winner_category.png'],
    ['Leader level', 'winner_level.png']
  ].freeze


  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users
  
  validates :title, presence: true, uniqueness: true  

  scope :user_badges, ->(user) { find(user.badges_users.pluck(:badge_id)) }
end
