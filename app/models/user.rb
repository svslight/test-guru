class User < ApplicationRecord
  has_many :user_tests
  
  def get_level_tests(level)
    #Test.select(:title).where(level: level).joins('JOIN user_tests ON test_id = tests.id').where('user_tests.user_id = ?', id)
    Test.select(:title).where(level: level).joins(:user_tests).where('user_tests.user_id = ?', id)
  end  
end
