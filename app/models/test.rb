class Test < ApplicationRecord
  belongs_to :category

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy

  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1).order(level: :asc) }
  scope :mid, -> { where(level: 2..4).order(level: :asc) }
  scope :hard, -> { where(level: 5..Float::INFINITY).order(level: :asc) } 
  
  scope :by_category, ->(category) { joins(:category).where(categories: { title: category }) }
  scope :by_level, ->(level) { where(level: level) }
 
  scope :with_category_admin, -> { joins(:category) }
  scope :with_category, -> { where(id: with_questions.pluck(:id)).joins(:category) }
  scope :with_questions, -> { joins(:questions).distinct }
  scope :levels, -> { select(:level).distinct.pluck(:level).sort }
end
