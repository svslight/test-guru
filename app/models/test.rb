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
  scope :get_category_tests, ->(name) { joins(:category).where(categories: {title: name}) }
  scope :with_questions, -> { joins(:questions).distinct }

  def self.order_by(name)
    get_category_tests(name).order(title: :desc).pluck(:title)
  end
end
