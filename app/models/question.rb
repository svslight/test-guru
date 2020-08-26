class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  has_many :test_passages, dependent: :destroy, class_name: 'TestPassage', foreign_key: 'current_question_id'
  has_many :gists, dependent: :destroy

  validates :body, presence: true
end
