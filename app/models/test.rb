class Test < ApplicationRecord
  belongs_to :category
  has_many   :questions
  has_many   :user_tests
  
  def self.get_category_tests(name)
    Test.joins(:category).where(categories: {title: name}).order('tests.title DESC').pluck('tests.title')
  end  
end
