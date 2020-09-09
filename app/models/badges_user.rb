class BadgesUser < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :count_badges, ->(user,  badge) { where(user_id: user.id, badge_id: badge.id).take }
  scope :count_badges_for, ->(user, rule) { where(user_id: user.id, badge_id: Badge.joins(:badge_rule).where(badge_rules: {rule: rule})).take }
  
  def self.badge_for(user, rule)
    where(user_id: user.id, badge_id: Badge.find_by(badge_rule_id: BadgeRule.find_by(rule: rule).id).id)
  end

end
