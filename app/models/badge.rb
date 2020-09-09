class Badge < ApplicationRecord
  IMAGES = [
    ['Leader attempt', 'winner_attempt.png'],
    ['Leader category', 'winner_category.png'],
    ['Leader level - 0', 'winner_level.png'],
    ['Leader level - 1', 'winner_level1.png'],
    ['Leader level - 2', 'winner_level2.png'],
    ['Leader level - 3', 'winner_level3.png'],
  ].freeze

  belongs_to :badge_rule

  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users
  
  validates :title, presence: true, uniqueness: true  

  scope :winned_badges, ->(user) { find(user.badges_users.pluck(:badge_id)) }
  scope :find_badge_id, ->(rule, level) { where(badge_rule_id: BadgeRule.find_by(rule: rule).id, level: level).take.id }
  
  def self.user_badges(user)
    @user_badges = []    
    @badges = self.winned_badges(user)

    @badges.each do |badge|
      @user_badges << [badge, BadgesUser.count_badges(user, badge).count_badges]
    end
    @user_badges
  end  
end
