class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many   :questions, dependent: :destroy
  has_many   :user_tests
  has_many   :users, through: :user_tests
  
  def self.get_category_tests(name)
    Test.joins(:category).where(categories: {title: name}).order('tests.title DESC').pluck('tests.title')
  end  
end
