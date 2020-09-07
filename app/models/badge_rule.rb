class BadgeRule < ApplicationRecord
  RULES = %w[
    attempt
    category
    level].freeze

  has_one :badge

  scope :badge_description, ->(badge) { find(badge.badge_rule_id).description }
  
  def self.list
    RULES
  end
end
