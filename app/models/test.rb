class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many   :questions, dependent: :destroy
  has_many   :user_tests, dependent: :destroy
  has_many   :users, through: :user_tests

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :validate_max_level, on: :create

  scope :easy, -> { where(level: 0..1).order(level: :asc) }
  scope :mid, -> { where(level: 2..4).order(level: :asc) }
  scope :hard, -> { where(level: 5..Float::INFINITY).order(level: :asc) }
  
  scope :get_category_tests, ->(name) { joins(:category).where(categories: {title: name}) }

  def self.order_by(name)
    get_category_tests(name).order(title: :desc).pluck(:title)
  end

  private

  def validate_max_level
    errors.add(:level) if level.to_i > 10
  end
end
