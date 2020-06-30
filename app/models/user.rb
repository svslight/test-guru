class User < ApplicationRecord
  has_many :user_tests
  
  def get_level_tests(level)
    Test.joins(:user_tests).where(tests: {level: level}, user_tests: {user_id: id}).pluck(:title)
  end  
end
